select * from products;
select * from employees;
select * from categories;
--1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
select product_name,quantity_per_unit from products;
--2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.,
select product_id,product_name from products where discontinued=1;
--3. Durdurulmayan (`Discontinued`) Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
select product_id,product_name from products where discontinued=0;
--4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
select product_id,product_name,unit_price from products where unit_price<20;
--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
select product_id,product_name,unit_price from products where unit_price between 15 and 25;
--6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
select product_name,units_on_order,units_in_stock from products where units_on_order > units_in_stock;
--7. İsmi `a` ile başlayan ürünleri listeleyeniz.
select * from products where product_name like 'A%';
--8. İsmi `i` ile biten ürünleri listeleyeniz.
select * from products where product_name like '%i';
--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
select product_name,unit_price,(unit_price*0.18) as"units_price_KDV" from products;
--10. Fiyatı 30 dan büyük kaç ürün var?
select * from products where unit_price>30;
--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
select lower(product_name),unit_price from products order by unit_price desc
--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
select  concat (first_name, ' ' ,last_name) as "first_last_name" from employees;
--13. Region alanı NULL olan kaç tedarikçim var?
select * from suppliers; select count(*) from suppliers where region is null;
--14. a.Null olmayanlar?
select count(*) from suppliers where region is not null;
--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
select concat('TR',' ',upper(product_name)) as"TRproduct_name" from products;
--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
select concat ('TR', '  ',product_name),unit_price  from products where unit_price<20;
--17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
select product_name,unit_price from products order by unit_price DESC ;
--18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
select product_name,unit_price from products order by unit_price desc limit 10;
--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
select product_name,unit_price from products where unit_price>(select avg(unit_price) from products);
--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
select (unit_price * units_in_stock) as "elde_edilen_miktar" from products
--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
select * from products where discontinued=1 and units_in_stock>0 ;
--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
select product_name,category_name from products,categories;
--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
select categories.category_name, avg(unit_price) as "Average Price" from products 
    inner join categories on products.category_id = categories.category_id group by categories.category_name;
--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
select product_name, unit_price, categories.category_name from products 
    inner join categories on products.category_id = categories.category_id 
        where unit_price = (select max(unit_price) from products);
--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
select products.product_name, categories.category_name, suppliers.company_name, sum(quantity) as "Total Quantity" from order_details 
    inner join products on products.product_id = order_details.product_id 
        inner join categories on categories.category_id = products.category_id 
            inner join suppliers on suppliers.supplier_id = products.supplier_id
                group by products.product_name , categories.category_name , suppliers.company_name 
                order by sum(quantity) desc limit 1;