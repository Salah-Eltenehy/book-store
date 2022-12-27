delimiter //
create trigger modify_book before update on book for each row 
		IF new.stock < 0 then
		call raise_error() ;
		END IF; //
delimiter ;

delimiter //
create trigger place_order after update on book for each row 
		IF new.stock < new.threshold then
		insert into book_order values
		(new.ISBN,new.threshold, new.publisher);
		END IF; //
delimiter ;

delimiter //
create trigger confirm_order before delete on book_order for each row 
	begin
		UPDATE book 
        SET stock = stock+ OLD.quantity 
        WHERE ISBN = OLD.ISBN ;
	end; //
delimiter ;
