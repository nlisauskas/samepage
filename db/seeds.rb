contractor_list = [
  ['John','Smith','Lincoln Home Services','Handyman','lincolnhomeservices@hotmail.com','12345678','12345678',' (312) 671-5553',],
['John','Smith','Mensch with a Wrench','Handyman','michael@menschwrenchchicago.com','12345678','12345678','(773) 791-7769',],
['John','Smith','Evanston Handyman','Handyman','office@evanstonhandyman.com','12345678','12345678','(847) 946-8079',]
]

contractor_list.each do |first_name, last_name, company, occupation, email, password, password_confirmation, phone|
  Contractor.create(first_name: first_name, last_name: last_name, company: company, occupation: occupation, email: email,
password: password,password_confirmation: password_confirmation, phone: phone)
end
