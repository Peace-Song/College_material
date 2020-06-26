import pymysql

connection = pymysql.connect(
	host='astronaut.snu.ac.kr',
	port=3306,
	user='20DB_2014_15703',
	password='20DB_2014_15703',
	db='20DB_2014_15703',
	charset='utf8',
	cursorclass=pymysql.cursors.DictCursor
)

menu_str = '\
================================================================================\n\
1. print all buildings\n\
2. print all performances\n\
3. print all audiences\n\
4. insert a new building\n\
5. remove a building\n\
6. insert a new performance\n\
7. remove a performance\n\
8. insert a new audience\n\
9. remove an audience\n\
10. assign a performance to a building\n\
11. book a performance\n\
12. print all performances which assigned at a building\n\
13. print all audiences who booked for a performance\n\
14. print ticket booking status of a performance\n\
15. exit\n\
16. reset database\n\
================================================================================\n'

# length: 80
bar_str = '\
--------------------------------------------------------------------------------'

# If a performance is in DB, return True
def performanceExist(conn, performanceID):
	try:
		with conn.cursor() as cursor:
			sql = 'SELECT ID FROM Performance'
			cursor.execute(sql)
			record = cursor.fetchall()
			
			if int(performanceID) in [ID_dict['ID'] for ID_dict in record]:
				return True
			else:
				return False
	
	except Exception as e:
		print(e)
		return False

# If a building is in DB, return True
def buildingExist(conn, buildingID):
	try:
		with conn.cursor() as cursor:
			sql = 'SELECT ID FROM Building'
			cursor.execute(sql)
			record = cursor.fetchall()
			
			if int(buildingID) in [ID_dict['ID'] for ID_dict in record]:
				return True
			else:
				return False
	
	except Exception as e:
		print(e)
		return False

# If an audience is in DB, return True
def audienceExist(conn, audienceID):
	try:
		with conn.cursor() as cursor:
			sql = 'SELECT ID FROM Audience'
			cursor.execute(sql)
			record = cursor.fetchall()
			
			if int(audienceID) in [ID_dict['ID'] for ID_dict in record]:
				return True
			else:
				return False
	
	except Exception as e:
		print(e)
		return False


# 1. print all buildings
def printBuildings(conn):
	try:
		print(bar_str)
		print('%-8s%-24s%-16s%-16s%-8s' % ('id', 'name', 'location', 'capacity', 'assigned'))
		print(bar_str)

		# Select number of performances assigned to the building even if none were assigned using an outer join
		with conn.cursor() as cursor:
			sql = '\
SELECT Building.ID as ID, Building.Name as name, Building.Location as location, Building.Capacity as capacity, IFNULL(Assigned.Num, 0) as num \
FROM Building LEFT OUTER JOIN \
(SELECT Building_ID, count(Performance_ID) as Num \
FROM Assigned \
GROUP BY Building_ID) as Assigned \
ON (Building.ID = Building_ID) \
ORDER BY Building.ID;'

			cursor.execute(sql)

			record = cursor.fetchone()
			while record is not None:
				print('%-8s%-24s%-16s%-16s%-8s' % (record['ID'], record['name'], record['location'], record['capacity'], record['num']))
				record = cursor.fetchone()

		print(bar_str)
		
	except Exception as e:
		print(e)

	print()

	return

# 2. print all performances
def printPerformances(conn):
	try:
		print(bar_str)
		print('%-8s%-24s%-16s%-16s%-8s' % ('id', 'name', 'type', 'price', 'booked'))
		print('')
		print(bar_str)

		# Select number of bookings to the performance even if none were booked using an outer join
		with conn.cursor() as cursor:
			sql = '\
SELECT Performance.ID as ID, Performance.Name as name, Performance.Type as type, Performance.Price as price, IFNULL(Book.Num, 0) as num \
FROM Performance LEFT OUTER JOIN \
(SELECT Perform_ID, count(Seat) as Num \
FROM Book \
GROUP BY Perform_ID) as Book \
ON (Performance.ID = Perform_ID) \
ORDER BY Performance.ID;'

			cursor.execute(sql)

			record = cursor.fetchone()
			while record is not None:
				print('%-8s%-24s%-16s%-16s%-8s' % (record['ID'], record['name'], record['type'], record['price'], record['num']))
				record = cursor.fetchone()

		print(bar_str)

	except Exception as e:
		print(e)

	print()

	return

# 3. print all audiences
def printAudiences(conn):
	try:
		print(bar_str)
		print('%-8s%-32s%-24s%-24s' % ('id', 'name', 'gender', 'age'))
		print(bar_str)

		# Simply select four columns
		with conn.cursor() as cursor:
			sql = 'SELECT ID, name, gender, age FROM Audience ORDER BY ID;'
			cursor.execute(sql)

			record = cursor.fetchone()
			while record is not None:
				print('%-8s%-32s%-24s%-24s' % (record['ID'], record['name'], record['gender'], record['age']))
				record = cursor.fetchone()

		print(bar_str)

	except Exception as e:
		print(e)

	print()

	return

# 4. insert a new building
def insertBuilding(conn):
	name = input('Building name: ')
	location = input('Building location: ')
	capacity = input('Building capacity: ')

	# Return if capacity lteq 0
	if int(capacity) <= 0:
		print('Capacity should be more than 0')
		return

	# Truncate if length over 200
	if len(name) > 200:
		name = name[:200]
	if len(location) > 200:
		location = location[:200]

	try:
		with conn.cursor() as cursor:
			sql = 'INSERT INTO Building (name, location, capacity) VALUES (\'{name}\', \'{location}\', {capacity});'.format(name=name, location=location, capacity=capacity)
			cursor.execute(sql)
			conn.commit()

			print('A building is successfully inserted\n')

	except Exception as e:
		print(e)

	return

# 5. remove a building
def removeBuilding(conn):
	buildingID = input('Building ID: ')

	# Check if the building is really in DB
	if not buildingExist(conn, buildingID):
		print('Building {ID} doesn\'t exist\n'.format(ID=buildingID))
		return

	try:
		with conn.cursor() as cursor:
			sql = 'DELETE FROM Building WHERE ID = {ID};'.format(ID=buildingID)
			cursor.execute(sql)
			conn.commit()

			print('A building is successfully removed\n')

	except Exception as e:
		print(e)
		print()
	
	return

# 6. insert a new performance
def insertPerformance(conn):
	name = input('Performance name: ')
	type_ = input('Performance type: ')
	price = input('Performance price: ')

	# Return if capacity less than 0
	if int(price) < 0:
		print('Price should be 0 or more\n')
		return

	# Truncate if length over 200
	if len(name) > 200:
		name = name[:200]
	if len(type_) > 200:
		type_ = type_[:200]

	try:
		with conn.cursor() as cursor:
			sql = 'INSERT INTO Performance (name, type, price) VALUES (\'{name}\', \'{type_}\', {price});'.format(name=name, type_=type_, price=price)
			cursor.execute(sql)
			conn.commit()

			print('A performance is successfully inserted\n')

	except Exception as e:
		print(e)
		print()

	return

# 7. remove a performance
def removePerformance(conn):
	performanceID = input('Performance ID: ')

	# Check if the performance is really in DB
	if not performanceExist(conn, performanceID):
		print('Performance {ID} doesn\'t exist\n'.format(ID=performanceID))
		return

	try:
		with conn.cursor() as cursor:
			sql = 'DELETE FROM Performance WHERE ID = {ID};'.format(ID=performanceID)
			cursor.execute(sql)
			conn.commit()

			print('A Performance is successfully removed\n')

	except Exception as e:
		print(e)
		print()
	
	return

# 8. insert a new audience
def insertAudience(conn):
	name = input('Audience name: ')
	gender = input('Audience gender: ')

	# Return if gender is either M or F
	if gender not in ['M', 'F']:
		print('Gender should be \'M\' or \'F\'\n')
		return

	age = input('Audience age: ')

	# Return if age lteq 0
	if int(age) <= 0:
		print('Age should be more than 0\n')
		return

	# Truncate if length over 200
	if len(name) > 200:
		name = name[:200]

	try:
		with conn.cursor() as cursor:
			sql = 'INSERT INTO Audience (name, gender, age) VALUES (\'{name}\', \'{gender}\', {age});'.format(name=name, gender=gender, age=age)
			cursor.execute(sql)
			conn.commit()

			print('An audience is successfully inserted\n')

	except Exception as e:
		print(e)
		print()

	return

# 9. remove an audience
def removeAudience(conn):
	audienceID = input('Audience ID: ')

	# Check if the audience is really in DB
	if not audienceExist(conn, audienceID):
		print('Audience {ID} doesn\'t exist\n'.format(ID=audienceID))
		return

	try:
		with conn.cursor() as cursor:
			sql = 'DELETE FROM Audience WHERE ID = {ID};'.format(ID=audienceID)
			cursor.execute(sql)
			conn.commit()

			print('An audience is successfully removed\n')

	except Exception as e:
		print(e)
		print()
	
	return

# 10. assign a performance to a building
def assignPerformanceToBuilding(conn):
	buildingID = input('Building ID: ')

	# Check if the building is really in DB
	if not buildingExist(conn, buildingID):
		print('Building {ID} doesn\'t exist\n'.format(ID=buildingID))
		return

	performanceID = input('Performance ID: ')

	# Check if the performance is really in DB
	if not performanceExist(conn, performanceID):
		print('Performance {ID} doesn\'t exist\n'.format(ID=performanceID))
		return

	try:
		with conn.cursor() as cursor:
			sql = 'INSERT INTO Assigned (Performance_ID, Building_ID) VALUES ({Performance_ID}, {Building_ID});'.format(Performance_ID=performanceID, Building_ID=buildingID)
			cursor.execute(sql)

			conn.commit()

			print('Successfully assigned a performance\n')

	except Exception as e:
		# PK constraint violation - performance must not have already been assigned to another building
		if e.args[0] == 1062:
			print('Performance {ID} is already assigned\n'.format(ID=performanceID))
		
		else:
			print(e)

		return

# 11. book a performance
def bookPerformance(conn):
	try:
		with conn.cursor() as cursor:
			# Retrieve performance ID
			performanceID = input('Performance ID: ')

			# Check if the performance is really in DB
			if not performanceExist(conn, performanceID):
				print('Performance {ID} doesn\'t exist\n'.format(ID=performanceID))
				return
			
			# Select the capacity of the building the performance was assigned to, and the price the performance has
			sql = '\
SELECT capacity, price \
FROM Building, Assigned, Performance \
WHERE Assigned.Performance_ID = {PerformanceID} \
and Assigned.Performance_ID = Performance.ID \
and Assigned.Building_ID = Building.ID;'.format(PerformanceID = performanceID)

			cursor.execute(sql)

			# If any, only one performance-building pair exists. Safe to use fetchone()
			capacity_price = cursor.fetchone()

			if not capacity_price:
				print('Performance {PerformanceID} isn\'t assigned\n'.format(PerformanceID=performanceID))
				return
			
			# Successfully retrieved capacity and price
			capacity = capacity_price['capacity']
			price = capacity_price['price']


			# Retrieve audience ID
			audienceID = input('Audience ID: ')

			# Check if the audience is really in DB
			if not audienceExist(conn, audienceID):
				print('Audience {ID} doesn\'t exist\n'.format(ID=audienceID))
				return

			# Select the age of the audience
			sql = 'SELECT age FROM Audience WHERE Audience.ID = {AudienceID};'.format(AudienceID=audienceID)
			cursor.execute(sql)

			# Successfully retrieved age
			age = int(cursor.fetchone()['age'])


			# Retrieve seat numbers
			seats_str = input('Seat number: ')

			# Parse seat numbers and store in list seats
			seats = []
			seats_str_list = seats_str.split(",")
			for seat_str in seats_str_list:
				seats.append(int(seat_str.strip()))

			# Check if seat valid or already booked
			sql = 'SELECT seat FROM Book WHERE Perform_ID = {PerformanceID};'.format(PerformanceID=performanceID)
			cursor.execute(sql)
			seats_raw = cursor.fetchall()
			booked_seats = [seat_dict['seat'] for seat_dict in seats_raw]

			for seat in seats:
				if seat < 1 or seat > capacity:
					print('Seat number out of range\n')
					return
				
				elif seat in booked_seats:
					print('The seat is already taken\n')
					return


			# May proceed with booking

			# Calculate effective price and total price
			effective_price = 0
			if 1 <= age and age < 8:
				effective_price = 0
			elif 8 <= age and age < 13:
				effective_price = price * 0.5
			elif 13 <= age and age < 19:
				effective_price = price * 0.8
			else:
				effective_price = price

			total_price = len(seats) * effective_price

			# Insert booking informations into the DB
			for seat in seats:
				sql = 'INSERT INTO Book (Perform_ID, Seat, Aud_ID) VALUES ({performanceID}, {seat}, {audienceID});'.format(performanceID=performanceID, seat=seat, audienceID=audienceID)
				cursor.execute(sql)
				conn.commit()

			print('Successfully booked a performance\nTotal ticket price is {price}\n'.format(price=total_price))

	except Exception as e:
		print(e)

	return

# 12. print all performances which assigned at a building
def printPerformancesAtBuilding(conn):
	buildingID = input('Building ID: ')

	# Check if the building is really in DB
	if not buildingExist(conn, buildingID):
		print('Building {ID} doesn\'t exist\n'.format(ID=buildingID))
		return

	try:
		print(bar_str)
		print('%-8s%-24s%-16s%-16s%-8s' % ('id', 'name', 'type', 'price', 'booked'))
		print(bar_str)
		
		# Join performance, assigned, and book so that all required informations are properly retrieved. Left outer join is to count null values as 0
		with conn.cursor() as cursor:
			sql = '\
SELECT PerfAsgn.ID as ID, PerfAsgn.Name as name, PerfAsgn.Type as type, PerfAsgn.Price as price, IFNULL(Book.Num, 0) as num \
FROM \
(SELECT * \
FROM Performance, Assigned \
WHERE Performance.ID = Assigned.Performance_ID \
and Assigned.Building_ID = {buildingID}) as PerfAsgn \
LEFT OUTER JOIN \
(SELECT Perform_ID, count(Seat) as Num \
FROM Book \
GROUP BY Perform_ID) as Book \
ON (PerfAsgn.ID = Book.Perform_ID) \
ORDER BY PerfAsgn.Id;'.format(buildingID=buildingID)

			cursor.execute(sql)

			record = cursor.fetchone()
			while record is not None:
				print('%-8s%-24s%-16s%-16s%-8s' % (record['ID'], record['name'], record['type'], record['price'], record['num']))
				record = cursor.fetchone()
			
		print(bar_str)

	except Exception as e:
		print(e)

	print()

	return

# 13. print all audiences who booked for a performance
def printAudiencesForPerformance(conn):
	performanceID = input('Performance ID: ')

	# Check if the performance really is in DB
	if not performanceExist(conn, performanceID):
		print('Performance {ID} doesn\'t exist\n'.format(ID=performanceID))
		return

	try:
		print(bar_str)
		print('%-8s%-32s%-24s%-24s' % ('id', 'name', 'gender', 'age'))
		print(bar_str)
		
		with conn.cursor() as cursor:
			# Select DISTINCT ID so that people who booked multiple seats for a performance can be counted without duplicate
			sql = '\
SELECT DISTINCT ID, name, gender, age \
FROM Audience, Book \
WHERE Perform_ID = {performanceID} and ID = Aud_ID;'.format(performanceID=performanceID)

			cursor.execute(sql)

			record = cursor.fetchone()
			while record is not None:
				print('%-8s%-32s%-24s%-24s' % (record['ID'], record['name'], record['gender'], record['age']))
				record = cursor.fetchone()
			
		print(bar_str)

	except Exception as e:
		print(e)

	print()

	return

# 14. print ticket booking status of a performance
def printTicketStatus(conn):
	performanceID = input('Performance ID: ')

	# Check if the performance is really in DB
	if not performanceExist(conn, performanceID):
		print('Performance {ID} doesn\'t exist\n'.format(ID=performanceID))
		return

	try:
		with conn.cursor() as cursor:
			# Select Building assigned to the performance
			sql = 'SELECT Building_ID FROM Assigned WHERE Performance_ID = {performanceID};'.format(performanceID=performanceID)
			cursor.execute(sql)

			# If retrieved none, the performance exists but not yet assigned
			if not cursor.fetchone():
				print('Performance {ID} isn\'t assigned\n'.format(ID=performanceID))
				return
			
			# Select the capacity of the building assigned to the performance
			sql = 'SELECT capacity FROM Assigned, Building WHERE Building_ID = ID and Performance_ID = {performanceID};'.format(performanceID=performanceID)
			cursor.execute(sql)
			capacity = cursor.fetchone()['capacity']

			# Select the seats and audience IDs of the performance
			# Same index for purchased_seats and purchased_audiences represents that the two are paired together
			sql = 'SELECT Seat, Aud_ID FROM Book WHERE Perform_ID = {performanceID} ORDER BY Seat;'.format(performanceID=performanceID)
			cursor.execute(sql)
			retrieved = cursor.fetchall()
			purchased_seats = [seat_dict['Seat'] for seat_dict in retrieved]
			purchased_audiences = [seat_dict['Aud_ID'] for seat_dict in retrieved]

			print(bar_str)
			print('%-40s%-40s' % ('seat_number', 'audience_id'))
			print(bar_str)

			for seat_num in range(1, capacity+1):
				if seat_num in purchased_seats:
					idx = purchased_seats.index(seat_num) # Find the index of current seat number
					print('%-40s%-40s' % (seat_num, purchased_audiences[idx])) # In purchased_audience with the same index is the corresponding audience ID
				else:
					print('{seat_num}'.format(seat_num=seat_num))

			print(bar_str)

	except Exception as e:
		print(e)

	print()

	return

# 16. reset database
def resetDB(conn):
	go = input("This action is irreversible. Are you sure? (y/n): ")
	if go == 'y' or go == 'Y':
		try:
			with conn.cursor() as cursor:
				# Drop tables
				cursor.execute('DROP TABLE Book;')
				cursor.execute('DROP TABLE Assigned;')
				cursor.execute('DROP TABLE Audience;')
				cursor.execute('DROP TABLE Performance;')
				cursor.execute('DROP TABLE Building;')

				sql_building = '\
CREATE TABLE Building (\n\
	ID INT NOT NULL AUTO_INCREMENT,\n\
	Name VARCHAR(200) NULL,\n\
	Location VARCHAR(200) NULL,\n\
	Capacity INT NULL,\n\
	PRIMARY KEY (ID));'

				sql_performance = '\
CREATE TABLE Performance (\n\
	ID INT NOT NULL AUTO_INCREMENT,\n\
	Name VARCHAR(200) NULL,\n\
	Type VARCHAR(200) NULL,\n\
	Price INT NULL,\n\
	PRIMARY KEY (ID));'

				sql_audience = '\
CREATE TABLE Audience (\n\
	ID INT NOT NULL AUTO_INCREMENT,\n\
	Name VARCHAR(200) NULL,\n\
	Gender VARCHAR(1) NULL,\n\
	Age INT NULL,\n\
	PRIMARY KEY (ID));'

				sql_assigned = '\
CREATE TABLE Assigned (\n\
	Performance_ID INT NOT NULL,\n\
	Building_ID INT NULL,\n\
	PRIMARY KEY (Performance_ID),\n\
	CONSTRAINT Building_ID\n\
		FOREIGN KEY (Building_ID)\n\
		REFERENCES Building (ID)\n\
		ON DELETE CASCADE\n\
		ON UPDATE NO ACTION,\n\
	CONSTRAINT Performance_ID\n\
		FOREIGN KEY (Performance_ID)\n\
		REFERENCES Performance (ID)\n\
		ON DELETE CASCADE\n\
		ON UPDATE NO ACTION);'

				sql_book = '\
CREATE TABLE Book (\n\
	Perform_ID INT NOT NULL,\n\
	Seat INT NOT NULL,\n\
	Aud_ID INT NULL,\n\
	PRIMARY KEY (Perform_ID, Seat),\n\
	CONSTRAINT Aud_ID\n\
		FOREIGN KEY (Aud_ID)\n\
		REFERENCES Audience (ID)\n\
		ON DELETE CASCADE\n\
		ON UPDATE NO ACTION,\n\
	CONSTRAINT Perform_ID\n\
		FOREIGN KEY (Perform_ID)\n\
		REFERENCES Performance (ID)\n\
		ON DELETE CASCADE\n\
		ON UPDATE NO ACTION);'

				# Create tables
				cursor.execute(sql_building)
				cursor.execute(sql_performance)
				cursor.execute(sql_audience)
				cursor.execute(sql_assigned)
				cursor.execute(sql_book)
				conn.commit()

				print('The database has been truncated.')

		except Exception as e:
			print(e)

	print()
	return

if __name__ == '__main__':
	cmd_num = -1
	print(menu_str)
	while True:
		cmd_num = input('Select your action: ')
		try:
			cmd_num = int(cmd_num)
		except ValueError as ve:
			cmd_num = -1
		
		if cmd_num == 1:
			printBuildings(connection)
		elif cmd_num == 2:
			printPerformances(connection)
		elif cmd_num == 3:
			printAudiences(connection)
		elif cmd_num == 4:
			insertBuilding(connection)
		elif cmd_num == 5:
			removeBuilding(connection)
		elif cmd_num == 6:
			insertPerformance(connection)
		elif cmd_num == 7:
			removePerformance(connection)
		elif cmd_num == 8:
			insertAudience(connection)
		elif cmd_num == 9:
			removeAudience(connection)
		elif cmd_num == 10:
			assignPerformanceToBuilding(connection)
		elif cmd_num == 11:
			bookPerformance(connection)
		elif cmd_num == 12:
			printPerformancesAtBuilding(connection)
		elif cmd_num == 13:
			printAudiencesForPerformance(connection)
		elif cmd_num == 14:
			printTicketStatus(connection)
		elif cmd_num == 15:
			print("Bye!\n")
			exit(0)
		elif cmd_num == 16:
			resetDB(connection)
		else:
			print("Invalid action\n")

