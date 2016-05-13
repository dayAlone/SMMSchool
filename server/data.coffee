if Days.find().count() == 0
	Days.insert
		sort  : 1
		name  : "Первое впечатление"
		description : "Какое впечатление мы производим. Разбор полётов."
		color : "#ed1d3f"
		date  : moment("20141115", "YYYYMMDD").toDate()
	Days.insert
		sort  : 2
		name  : "Скелеты в шкафу. Разбор гардероба"
		description : "Разбор и анализ гардероба. Поиск монстров в шкафу."
		color : "#fd7622"
		date  : moment("20141118", "YYYYMMDD").toDate()
	Days.insert
		sort  : 3
		name  : "Работа с цветом"
		description : "Цветовые схемы и цветовой круг. Цветотип."
		color : "#fec62e"
		date  : moment("20141119", "YYYYMMDD").toDate()
	Days.insert
		sort  : 4
		name  : "Формирование гардероба"
		description : "Методы создания рационального гардероба."
		color : "#518e29"
		date  : moment("20141120", "YYYYMMDD").toDate()
	Days.insert
		sort  : 5
		name  : "Каталог вещей"
		description : "Создание персонального архива с вещами и аксессуарами."
		color : "#177ab4"
		date  : moment("20141121", "YYYYMMDD").toDate()
	Days.insert
		sort  : 6
		name  : "Планирование гардероба"
		description : "Работа с потребностями. Бюджет. Экономия и инвестирование."
		color : "#143c51"
		date  : moment("20141122", "YYYYMMDD").toDate()
	Days.insert
		sort  : 7
		name  : "Итоги и результаты"
		description : "Подведение итогов. Обратная связь от всех участников."
		color : "#491e4f"
		date  : moment("20141123", "YYYYMMDD").toDate()
