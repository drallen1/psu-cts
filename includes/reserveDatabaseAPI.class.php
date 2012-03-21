<?php
class reserveDatabaseAPI{

	function by_date($date){
		$sql="
			SELECT * FROM cts_reservation
			WHERE start_date = ? OR end_date =	?
			";
		$dates=array($date,$date);
		return PSU::db('cts')->GetAssoc( $sql, $dates);

	}//end function by_date

	function by_start_date($date){
		$sql="
			SELECT * FROM cts_reservation
			WHERE start_date = ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $date);

	}//end function by_start_date

	function by_end_date($date){
		$sql="
			SELECT * FROM cts_reservation
			WHERE end_date = ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $date);

	}//end function by_end_date

	function by_lname($lname){
		$sql="
			SELECT * FROM cts_reservation
			WHERE lname = ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $lname);

	}//end function by_lname

	function by_fname($fname){
		$sql="
			SELECT * FROM cts_reservation
			WHERE fname = ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $fname);

	}//end function by_fname

	function by_status($status){
		$sql="
			SELECT * FROM cts_reservation
			WHERE status = ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $status);

	}//end function by_status

	function by_current_status($status){
		$sql="
			SELECT * FROM cts_reservation
			WHERE current_status = ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $status);

	}//end function by_status

	function by_building($building){
		$sql="SELECT building_idx  FROM cts_building WHERE name = ?";
		$building_idx=PSU::db('cts')->GetOne( $sql,$building);
		
		$sql="
			SELECT * FROM cts_reservation
			WHERE building_idx = ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $building_idx);

	}//end function by_building

	function by_title($title){
		$sql="
			SELECT * FROM cts_reservation
			WHERE title = ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $title);

	}//end function by_status
	
	function by_date_range($dates){
		$sql="
			SELECT * FROM cts_reservation
			WHERE start_date BETWEEN ? AND ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $dates);


	}//end function by date_range

	function by_date_range_next_week(){
		$start_date=date('Y-m-d', strtotime("+1 week"));
		$end_date=date('Y-m-d', strtotime("+2 week"));
		$dates=array($start_date, $end_date);

		$sql="
			SELECT * FROM cts_reservation
			WHERE start_date BETWEEN ? AND ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $dates);


	}//end function by date_range_next_week

	function by_id($id){
		$sql="
			SELECT * FROM cts_reservation
			WHERE reservation_idx = ?	
			";
		return PSU::db('cts')->GetAssoc( $sql, $id);

	}//end function by_id

	function categories(){
		
		$sql="SELECT categoryID, category_name FROM cts_form_options";

		return PSU::db('cts')->GetAssoc( $sql );

	}//end function categories

	function insertReservation($last_name, $first_name, $phone, $email, $application_date, $start_date, $start_time, $end_date, $end_time, $comments, $building, $room, $title, $delivery_type, $requested_items, $status){

		$sql="
		INSERT INTO cts_reservation 
			(lname,
			fname,
			phone,
			email,
			application_date,
			start_date,
			end_date,
			start_time,
			end_time,
			memo,
			building_idx,
			room,
			title,
			delivery_type,
			request_items,
			status) 
		VALUES 
			(?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?, 
			?)";
			
		PSU::db('cts')->Execute( $sql, array($last_name, 
			$first_name, 
			$phone, 
			$email, 
			$application_date, 
			$start_date, 
			$end_date, 
			$start_time, 
			$end_time, 
			$comments, 
			$building, 
			$room, 
			$title, 
			$delivery_type, 
			$requested_items, 
			$status));
			
	}//end function insertReservation

	function itemInfo($item_id){
		$sql="SELECT description FROM cts_form_options WHERE categoryID=$item_id";

		return PSU::db('cts')->GetOne( $sql );
	}

	function locations(){

		$sql="SELECT building_idx, name  FROM cts_building";
		return PSU::db('cts')->GetAssoc( $sql );

	}//end function locations

}//end class reserveDatabaseAPI