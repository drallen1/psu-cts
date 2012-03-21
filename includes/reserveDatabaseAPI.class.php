<?php
class reserveDatabaseAPI{


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
