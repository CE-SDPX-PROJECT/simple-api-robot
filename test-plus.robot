*** Settings ***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create Session    flask_api    http://127.0.0.1:5000

*** Test Cases ***
Test Plus With Two Positive Integers
  ${response}=    GET On Session    flask_api    /plus/5/3
  Status Should Be    200    ${response}
  ${json}=    Set Variable    ${response.json()}
  Dictionary Should Contain Value    ${json}    8

Test Plus With Two Negative Integers
  ${response}=    GET On Session    flask_api    /plus/-5/-3
  Status Should Be    200    ${response}
  ${json}=    Set Variable    ${response.json()}
  Dictionary Should Contain Value    ${json}    -8

Test Plus With Positive And Negative Numbers
  ${response}=    GET On Session    flask_api    /plus/-5/8
  Status Should Be    200    ${response}
  ${json}=    Set Variable    ${response.json()}
  Dictionary Should Contain Value    ${json}    3

Test Plus With Decimal Numbers
  ${response}=    GET On Session    flask_api    /plus/5.5/3.3
  Status Should Be    200    ${response}
  ${json}=    Set Variable    ${response.json()}
  Dictionary Should Contain Value    ${json}    8.8

Test Plus With Large Numbers
  ${response}=    GET On Session    flask_api    /plus/999999999999/1
  Status Should Be    200    ${response}
  ${json}=    Set Variable    ${response.json()}
  Dictionary Should Contain Value    ${json}    1000000000000

Test Plus With Zero Values
  ${response}=    GET On Session    flask_api    /plus/0/0
  Status Should Be    200    ${response}
  ${json}=    Set Variable    ${response.json()}
  Dictionary Should Contain Value    ${json}    0

Test Plus With Invalid First Parameter
  ${response}=    GET On Session    flask_api    /plus/abc/5    expected_status=400
  Status Should Be    400    ${response}
  ${json}=    Set Variable    ${response.json()}
  Dictionary Should Contain Key    ${json}    error

Test Plus With Invalid Second Parameter
  ${response}=    GET On Session    flask_api    /plus/5/abc    expected_status=400
  Status Should Be    400    ${response}
  ${json}=    Set Variable    ${response.json()}
  Dictionary Should Contain Key    ${json}    error

Test Plus With Both Invalid Parameters
  ${response}=    GET On Session    flask_api    /plus/abc/xyz    expected_status=400
  Status Should Be    400    ${response}
  ${json}=    Set Variable    ${response.json()}
  Dictionary Should Contain Key    ${json}    error