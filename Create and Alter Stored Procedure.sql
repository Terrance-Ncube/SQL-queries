

--create procedure dbo.spNashvilleHousing_GetByAddress
--	@PropertyAddress nvarchar(255)
--as begin
--	select [UniqueID ], PropertyAddress, salePrice
--	from dbo.NashvilleHousing
--	where PropertyAddress = @PropertyAddress;

--end

--exec dbo.spNashvilleHousing



-- Passing multiple variables

alter procedure dbo.spNashvilleHousing_GetByAddress
	@PropertyAddress nvarchar(255),
	@salePrice float
as begin
	select [UniqueID ], PropertyAddress, salePrice, LandUse
	from dbo.NashvilleHousing
	where PropertyAddress = @PropertyAddress;
end

--exec dbo.spNashvilleHousing_GetByAddress '1808  FOX CHASE DR, GOODLETTSVILLE',24000