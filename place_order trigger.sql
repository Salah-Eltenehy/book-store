delimiter //
create trigger place_order after update on book for each row 
		IF new.stock < new.threshold then
		insert into book_order values
		(new.ISBN,new.threshold, new.publisher);
		END IF; //
delimiter ;
