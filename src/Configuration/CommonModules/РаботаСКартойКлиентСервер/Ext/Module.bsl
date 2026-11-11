Функция ШаблонКарты() 
	ШаблонКарты =
		"<!DOCTYPE html>
		|<html xmlns=""http://www.w3.org/1999/xhtml""> 
		|<head>
		|<title>Адрес читателя</title>
		|<meta name=""viewport""
		|content=""user-scalable=no, width=device-width, initial-scale=1,
		|maximum-scale=1"">
		|<meta name="" format-detection"" 
		|content=""telephone=no"">
		| <meta http-equiv=""Content-Type""
		|content=""text/html; charset=utf-8"" />
		|<script
		|src=""https://api-maps.yandex.ru/2.1/?apikey=b1110e6f-6abf-4fbc-a433-4b43cc9640a8&lang=ru_RU""
		|type=""text/javascript"">
		|</script>
		|<style>
		|html, body, #map {width: 100%%; height: 100%%; padding:0; margin: 0;
		|}
		|</style>
		|<script type=""text/javascript"">
		|%1 
		|</script>
		|</head>
		|<body>
		|<div id=""map""></div>
		|</body>
		|</html>";
	Возврат ШаблонКарты;
Конецфункции 

Функция ЦентрКартыПоУмолчанию()
	Возврат Новый Структура("Широта, Долгота", "55.76", "37.64");
КонецФункции



Функция ПолучитьКарту (Масштаб, ЦентрКарты = Неопределено, Координаты = Неопределено) Экспорт
	КартаHTMLШаблон = ШаблонКарты();
	СкриптШаблон = "ymaps.ready(init); function init(){
		|var myMap = new ymaps.Map(""map"", {
		|%1
		|zoom: %2,
		|controls: []
		|});
		|%3}";
	МеткиНаКарте = "";
	МеткаШаблон = "var myGeoObject = new ymaps.GeoObject({
		|    geometry: {
		|        type: ""Point"", 
		|        coordinates: [%1, %2]}});
		|myMap.geoObjects.add(myGeoObject);
		|";
	Если Центркарты = Неопределено Тогда
		ЦентрКарты = ЦентрКартыПоУмолчанию();
	КонецЕсли;
	ЦентрКарты = "center: ["+ЦентрКарты.Широта+", "+ЦентрКарты.Долгота+"],";
	Метка = "";
	Если Координаты <> Неопределено Тогда
		Метка = СтрШаблон (МеткаШаблон, Координаты[1], Координаты[0]);
	КонецЕсли;
	Скрипт = СтрШаблон(СкриптШаблон, ЦентрКарты, Масштаб, Метка); 
	КартаHTML = СтрШаблон(КартаHTMLШаблон, Скрипт);
	Возврат КартаHTML;
Конецфункции
