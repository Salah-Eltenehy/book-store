delimiter //
create TRIGGER confirm_order before delete on book_order for each row 
	begin
		UPDATE book 
        SET stock = stock+ OLD.quantity 
        WHERE ISBN = OLD.ISBN ;
	end; //
delimiter ;
