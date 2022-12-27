delimiter //
create trigger modify_book before update on book for each row 
		IF new.stock < 0 then
		call raise_error() ;
		END IF; //
delimiter ;

	 