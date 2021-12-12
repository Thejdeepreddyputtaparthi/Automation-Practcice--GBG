*** Settings ***

Library	SeleniumLibrary
Library	Collections
Library	String
Library	OperatingSystem
Library	DateTime


*** Variables ***

${browser}  chrome
${env}   iot
${platform}   mac
${remote_url}	None
${URL}  https://www.surveymonkey.com/r/9MVSPYS


${good_radio_button}   //span[contains(text(),"Good")]
${next_button}  //button[@type="submit"]
${text_displayed}   //*[@id="patas"]/main//div[contains(@class,"h3")]//div



*** Keywords ***


Setup Browser
	[Arguments]	${platform}	${env}
	Run Keyword If	'${platform}'=='mac'	Setup Mac
	Set Global Variable	${env}


Setup Mac
	Run keyword If	'${remote_url}'=='None' 	Launch Chrome
	...  ELSE	Sleep   3
	Run keyword If  '${remote_url}'=='None'  Maximize Browser Window
	...  ELSE    Set Window Size    1400    900

Launch Chrome 
	${options}=	Evaluate	sys.modules['selenium.webdriver'].ChromeOptions()   sys, selenium.webdriver
	${prefs}	Create Dictionary   credentials_enable_service=${false}    default_content_settings=2   managed_default_content_settings=2       #default_content_setting_values=2
	Call Method	${options}	add_experimental_option	prefs	${prefs}
	Call Method	${options}	add_argument	disable-infobars  
	Create WebDriver	Chrome	chrome_options=${options}

launch surveymoney home page  
	[Arguments]	 ${url}
	Go To	${url}

verify page is loaded
    Run Keyword and continue on Failure	Wait Until Element Is Visible	${good_radio_button}	timeout=12  
	Sleep  3 

select Good radio button option 
    Run Keyword and continue on Failure	Wait Until Element Is Visible	${good_radio_button}	timeout=12
	Run Keyword and continue on Failure	Wait Until Keyword Succeeds	5x	500ms	Click Element	${good_radio_button}

click next button
    Run Keyword and continue on Failure	Wait Until Element Is Visible	${next_button}	timeout=12
	Run Keyword and continue on Failure	Wait Until Keyword Succeeds	5x	500ms	Click Element	${next_button}
	Sleep  2

verify text exists have a nice day
    Run Keyword and continue on Failure    Wait Until Element Is Visible   ${text_displayed}   timeout=12
    ${submit_text}=        Get Text        ${text_displayed}
	Log   ${submit_text}


