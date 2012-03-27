<script>
$(function(){
	$( "#startdate , #enddate" ).datepicker();
});
</script>
{include file='search.tpl'}
{box title="Reservation ID: $reservation_idx"}
<ul class="clean">
{assign var=reserve value=$reservation[$reservation_idx]}
{if $editable}
<form class="label-left" name ="event_info" method="POST" action="{$PHP.BASE_URL}/reserve/event">
          <ul>
		<li>
          	<h4>Contact Information:</h4>
          </li>

          <li>
          	<label class="required">First Name:<em>*</em></label>
          	<input type="text" name="first_name" size="25" value="{$reserve.fname}"></input>
          </li>

          <li>  
          	<label class="required">Last Name:<em>*</em></label>
          	<input type="text" name="last_name" size="25" value="{$reserve.lname}">
          </li>

          <li>
          	<label class="required">Phone Number:<em>*</em></label>
          	<input id="phone" type="text" name="phone" size="14" value="{$reserve.phone}">
          </li>
		<li>
          	<label>Secondary Phone Number(Cell):</label>
          	<input id="phone" type="text" name="secondary_phone" size="14" value="{$reserve.secondary_phone}">
          </li>

          <li>
          	<label class="required">Campus Email:<em>*</em></label>
          	<input type="email" name ="email" value="{$reserve.email}"> <!-- wp_email -->
		</li>
            <li>
              <h4>Event Information: </h4>
            </li>
            <li>
              <label class="required">Event Title or Course Number and Section:<em>*</em></label>
              <input type="text" name="title" size="25" value="{$reserve.title}">
            </li>
            <li>
              <label class="required">Location:<em>*</em></label>
			{html_options name=location options=$locations selected=$reserve.building_idx}
		  </li>
		  <li>
		    <label class="required">Room Number:<em>*</em></label>
              <input type="text" name="room" size="5" value="{$reserve.room}">
            </li>
            <li>
             <label>Purpose, Details or Comments:</label>
             <textarea  name="comments" rows="5" cols="40">{$reserve.memo}</textarea>
            </li>
		  <li>
		  	<label class="required">Event Start:<em>*</em></label>
		  	<input id="startdate" type="text" name="start_date" readonly="true"
			value="{$reserve.start_date|date_format:'%l/%e/%Y'}"> at 
			{html_options name=starthour options=$hours selected=$reserve.starthour}
			:
			{html_options name=startminute options=$minutes|string_format:"%02d" selected=$reserve.startminute}
			
			-
			{html_options name=startampm options=$ampm selected=$reserve.startampm}
		  </li>
		  <li>
		  	<label class="required">Event End:<em>*</em></label>
		  	<input id="enddate" type="text" name="end_date" readonly="true" value="{$reserve.end_date|date_format:'%l/%e/%Y'}"> at
			{html_options name=endhour options=$hours selected=$reserve.endhour}
			
			:
			{html_options name=endminute options=$minutes|string_format:"%02d" selected=$reserve.endminute}
			-
			{html_options name=endampm options=$ampm selected=$reserve.startampm}
		   </li>
		   <li>
		<input type="radio" id="equipment" name="radio" value="equipment" checked="true"/>I will pick up and return the equipment to the learning Commons Information Desk in Lamson Library
		  </li>
		  <li>
			<input type="radio" id="sponsored" name="radio" value="sponsored" />I will need the Classrom Technology Staff to deliver and retrieve the equipment at the location specified
		  </li>
		  <li>
              <input type="Submit" name="Edit_event" value="Submit Changes">
            </li>
 	 </ul>
	</form>

{else}
	<h2>Contact Information</h2>
			<li><strong>Name: </strong>{$reserve.fname} {$reserve.lname}</li>
			<li><strong>Phone: </strong>{$reserve.phone}</li>
			{if $reserve.secondary_phone}
				<li><strong>Secondary Phone: </strong>{$reserve.secondary_phone}</li>
			{/if}
			<li><strong>Email: </strong>{$reserve.email}</li>
	<h2>Event Information</h2>
			<li><strong>Application date: </strong>{$reserve.application_date|date_format:$date_format} <strong> at </strong> {$reserve.application_date|date_format:$time_format}</li>
			<li><strong>Start Date: </strong>{$reserve.start_date|date_format:$date_format}</li>		
			<li><strong>Start Time: </strong>{$reserve.start_time|date_format:$time_format}</li>		
			<li><strong>End Date: </strong>{$reserve.end_date|date_format:$date_format}</li>		
			<li><strong>End Time: </strong>{$reserve.end_time|date_format:$time_format}</li>		
			<li><strong>Location: </strong>{$locations[$reserve.building_idx]} <strong>in room</strong> {$reserve.room}</li>
			<!--
			{html_options name=location options=$locations selected=$reserve.building_idx}
			THIS IS FOR EDITING 
			-->
			<li><strong>Title: </strong>{$reserve.title}</li>		
			<li><strong>Status of Loan: </strong>{$reserve.status}</li>
			<li><strong>Comments: </strong><p>{$reserve.memo}</p></li>
			<li><strong>Requested Items: </strong><p>{$reserve.request_items}</p></li>

		<h2>Equipment Assigned</h2>
		<table class="grid" width="450">
		<thead>
			<tr>
				<th>GLPI ID</th>
				<th>CTS ID</th>
				<th>Type</th>
				<th>Model</th>
			</tr>
		</thead>
		<tbody>
		{foreach from=$equipment item=equipment key=id}
			<tr>
				<td>GPLI ID</td>
				<td>{$equipment.equipment_idx}</td>
				<td>Type</td>
				<td>Model</td>
			</tr>
		{/foreach}
		</tbody>
		</table>
	</ul>
{/if}
	<h2>Messages</h2>
	<ul class="clean">
		<form method="post" action="{$PHP.BASE_URL}/admin/reservation/addmessage/{$reservation_idx}">
			<li><textarea cols="60" name="message"></textarea></li>
			<li><input type="submit" name="submit" value="Add New Message"></li>

			{foreach from=$messages item=message key=id}
				<li><strong>{$message.author} at {$message.time|date_format:$time_format} on {$message.date|date_format:$date_format}: </strong>{$message.message}<br></li>
			{/foreach}
	<li><a href="{$PHP.BASE_URL}/admin/reservation/search/id/{$reservation_idx}/edit" class="button">Edit Reservation</a>
<a href="{$PHP.BASE_URL}/admin/reservation/search/id/{$reservation_idx}/delete" class="button">Delete Reservation</a></li>
	</ul>
{/box}