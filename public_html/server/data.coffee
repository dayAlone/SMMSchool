if Invitations.find().count() == 0
	
	Invitations.insert
		invitationId : CryptoJS.MD5('andrey.slider@gmail.com').toString()
		email        : 'andrey.slider@gmail.com'
		used         : false
		admin        : true

	Invitations.insert
		invitationId : CryptoJS.MD5('ksy.zimina@gmail.com').toString()
		email        : 'ksy.zimina@gmail.com'
		used         : false
		admin        : true

	Invitations.insert
		invitationId : CryptoJS.MD5('sashanatasha-vol@yandex.ru').toString()
		email        : 'sashanatasha-vol@yandex.ru'
		used         : false
		admin        : false
	Invitations.insert
		invitationId : CryptoJS.MD5('orvat86@mail.ru').toString()
		email        : 'orvat86@mail.ru'
		used         : false
		admin        : false
	Invitations.insert
		invitationId : CryptoJS.MD5('aygul.khabirova@gmail.com').toString()
		email        : 'aygul.khabirova@gmail.com'
		used         : false
		admin        : false
	Invitations.insert
		invitationId : CryptoJS.MD5('marmalattoo@gmail.com').toString()
		email        : 'marmalattoo@gmail.com'
		used         : false
		admin        : false
	Invitations.insert
		invitationId : CryptoJS.MD5('bonbonroom@gmail.com').toString()
		email        : 'bonbonroom@gmail.com'
		used         : false
		admin        : false
	Invitations.insert
		invitationId : CryptoJS.MD5('guzova2013@gmail.com').toString()
		email        : 'guzova2013@gmail.com'
		used         : false
		admin        : false
	Invitations.insert
		invitationId : CryptoJS.MD5('yuliannakh@mail.ru').toString()
		email        : 'yuliannakh@mail.ru'
		used         : false
		admin        : false
	Invitations.insert
		invitationId : CryptoJS.MD5('wsy_putym15@mail.ru').toString()
		email        : 'wsy_putym15@mail.ru'
		used         : false
		admin        : false
	Invitations.insert
		invitationId : CryptoJS.MD5('miholesya@gmail.com').toString()
		email        : 'miholesya@gmail.com'
		used         : false
		admin        : false

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
