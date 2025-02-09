/* DATA CLEANING
Data cleaning is the process of transforming raw data into a more usable format by correcting errors and addressing issues. 
This ensures that when we create visualizations or use the data in our products, it is accurate and reliable, free from significant 
problems that could affect its usefulness.

Steps for cleaning the data:
1. Check and Remove duplicates if any exists
2. Standaradize the data (Issuse with spelings, spaces etc.)
3. Look on null and blank values.
4. Remove the un-necessary column and rows.
*/

SELECT * 
FROM layoffs;

-- Creating duplicate of original table so that raw data is available
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging  # Importing all data from layoffs.
SELECT *
FROM layoffs;

-- STEP 1: IDENITFY AND REMOVE DUPLICATES
/*
This query add a new column, row_num, to the result set of the layoffs_stagging table.
This column contains sequential numbers starting at 1 for each group of rows that have the same values
for the company, industry, total_laid_off, percentage_laid_off, and date columns.
*/
SELECT * ,
ROW_NUMBER() OVER(
	PARTITION BY 
		company, 
		location, 
		industry, 
        total_laid_off, 
        percentage_laid_off, 
        `date`, 
        stage, 
        country, 
        funds_raised_millions) AS row_num
FROM layoffs_staging;

# Creating a CTE to identify the duplicate rows
WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER() OVER(
	PARTITION BY 
		company, 
        location, 
        industry, 
        total_laid_off, 
        percentage_laid_off, 
        `date`, 
        stage, 
        country, 
        funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *    # Checking the duplicates
FROM layoffs_stagging 
WHERE company = 'Beyond Meat';

-- REMOVING DUPLICATES

-- Creating copy of table with new column (layoffs_staging2)
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL, 
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country
, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE 
FROM layoffs_staging2
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging2;

-- STEP 2: STANDARDIZING DATA (company, industry, country, date)

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);
-- -----------------------------------------------------

SELECT *
FROM layoffs_stagging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';
-- -----------------------------------------------------

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2 
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';
-- -----------------------------------------------------

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');  # converting into dae format

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- STEP 3: NULL AND DUPLICATE VALUES (populating industry)
# Looking into the null and blank spaces
SELECT *    
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

# Setting the null value to blanks to make it easier
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT DISTINCT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

SELECT *
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

 -- Populate the missing industry data
UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


-- STEP 4: REMOVING UNNECESSARY ROWS AND COLUMNS
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2;

# Dropping the row_num column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;