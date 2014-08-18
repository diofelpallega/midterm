 
CREATE TABLE restaurantmenu(
    counter int primary key,
	beverages text,
	price text,
	morningspecial text,
	price2 text,
	lunchmode text,
	price3 text,
	dinnerlicious text,
	price4 text,
	dessertful text,
	price5 text,
	chipsandcrackers text,
	price6 text
	
);

 

create or replace function
   setrestaurantmenu(p_counter int,p_beverages text,p_price text,p_breakfast text,p_price2 text, p_lunch text,p_price3 text, p_dinner text,p_price4 text,p_dessert text,p_price5 text,p_chipsandcrackers text,p_price6 text)
     returns text as
$$
   declare
      counter1 int;
   begin
      select into counter1 counter from restaurantmenu
         where counter = p_counter;
	  
      if counter1 isnull then
         insert into restaurantmenu(counter,beverages,price,morningspecial,price2,lunchmode,price3,dinnerlicious,price4 ,dessertful,price5,chipsandcrackers,price6) values
            (p_counter,p_beverages,p_price,p_breakfast,p_price2 ,p_lunch,p_price3,p_dinner,p_price4,p_dessert,p_price5 ,p_chipsandcrackers,p_price6 );
     else
          update restaurantmenu
			set counter = p_counter,beverages= p_beverages, morningspecial = p_breakfast,lunchmode= p_lunch,dinnerlicious=p_dinner,dessertful=p_dessert,chipsandcrackers=p_chipsandcrackers 
			where counter = p_counter;
      end if;
	  return 'OK';
  end;
$$
language 'plpgsql';
-- HOW TO USE :
-- SELECT setrestaurantmenu('1','coke 12 oz','12 pesos','Sunnysideup','22 pesos','Special kinilaw 1 bowl','68 pesos','adobong manok','89 pesos','Chicken Salad','28 pesos','Banana chips 20 pcs','20 pesos'); 

--view
create or replace function
   get_restaurantmenu_perid(in int,out text,out text,out text,out text,out text,out text,out text,out text,out text, out text, out text,out text)
returns setof record as
$$
	select morningspecial,price2,lunchmode,price3,dinnerlicious,price4 ,dessertful,price5,chipsandcrackers,price6,beverages,price from restaurantmenu
	where counter = $1;

$$
  language 'sql';

-- HOW TO USE:
-- SELECT get_restaurantmenu_perid(1);