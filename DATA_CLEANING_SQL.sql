use case1;

--Cleaning Data in SQL Queries



Select *
From case1.dbo.NashvilleHousing;


-- Standardize Date Format

Select SaleDate,CONVERT(Date,SaleDate) as SaleDateConverted
From case1.dbo.NashvilleHousing;


-- Populate Property Address data

Select *
From case1.dbo.NashvilleHousing
--Where PropertyAddress is null
order by ParcelID

--Handling the null address

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,ISNULL(a.PropertyAddress, b.PropertyAddress)
From case1.dbo.NashvilleHousing a
JOIN case1.dbo.NashvilleHousing b
on a.ParcelID=b.ParcelID
AND  a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From case1.dbo.NashvilleHousing a
JOIN case1.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
From case1.dbo.NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID



SELECT SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) AS ADDRESS,

SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))AS ADDRESS
From case1.dbo.NashvilleHousing



ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity =SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))

Select *
From case1.dbo.NashvilleHousing
--Address and City split

--alternate way of extracting address, city and state
Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From case1.dbo.NashvilleHousing


--now adding these columns to our main table
ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

Select *
From case1.dbo.NashvilleHousing


-- Change Y and N to Yes and No in "Sold as Vacant" field

Select DISTINCT(SoldAsVacant),COUNT(SoldAsVacant) From case1.dbo.NashvilleHousing
group by SoldAsVacant
order by SoldAsVacant desc




SELECT SoldAsVacant,
CASE 
    WHEN SoldAsVacant= 'Y' THEN 'YES'
	WHEN SoldAsVacant= 'N' THEN 'NO'
	ELSE SoldAsVacant
	END
	From case1.dbo.NashvilleHousing

	UPDATE NashvilleHousing
	SET SoldAsVacant=
   CASE 
       WHEN SoldAsVacant= 'Y' THEN 'YES'
	   WHEN SoldAsVacant= 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END
	   From case1.dbo.NashvilleHousing


-- Delete Unused Columns



Select *
From case1.dbo.NashvilleHousing


ALTER TABLE CASE1.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

