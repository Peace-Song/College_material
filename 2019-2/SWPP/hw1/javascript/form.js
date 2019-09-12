class Form {
    constructor(
      email,
      password,
      password_confirmation,
      phone_number,
      fname,
      lname,
      age,
      birth_month,
      birth_day,
      birth_year) {
        this.email = email;
        this.password = password;
        this.password_confirmation = password_confirmation;
        this.phone_number = phone_number;
        this.fname = fname;
        this.lname = lname;
        this.age = age;
        this.birth_month = birth_month;
        this.birth_day = birth_day;
        this.birth_year = birth_year;
        }
    // TODO: You may fill in functions in the class.

  }

  var but = document.createElement('button');
  but.innerHTML = "Check";
  but.onclick = function() {
      var email = document.forms["form"]["email"].value;
      // TODO: Fill in the rest of the function. Use the Form class defined above
      
      console.log("email == %s", email);
      var email_pattern = /^[^ \t\n\r\f\v@]+@[^ \t\n\r\f\v@.]+[.][a-zA-Z]{2,3}$/;
      var email_ok = email_pattern.test(email);
      console.log(email_ok ? "email in pattern" : "email NOT in patern");

      var password = document.forms["form"]["password"].value;
      console.log("password == %s", password);
      var password_pattern = /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
      var password_ok = password_pattern.test(password);
      console.log(password_ok ? "password in pattern" : "password NOT in pattern");

      var password_confirmation = document.forms["form"]["password-confirmation"].value;
      console.log("password_confirmation == %s", password_confirmation);
      var password_confirmation_ok = password == password_confirmation ? true : false;
      console.log(password_confirmation_ok ? "password valid" : "password invalid");

      var phone_number = document.forms["form"]["phone-number"].value;
      console.log("phone_number == %s", phone_number);
      var phone_number_pattern = /^\d{3}-\d{4}-\d{4}$/;
      var phone_number_ok = phone_number_pattern.test(phone_number);
      console.log(phone_number_ok ? "phone number in pattern" : "phone number NOT in pattern");
       
      var fname = document.forms["form"]["fname"].value;
      console.log("fname == %s", fname);
      var fname_pattern = /^[A-Z][a-z]+$/;
      var fname_ok = fname_pattern.test(fname);
      console.log(fname_ok ? "fname in pattern" : "fname NOT in pattern");

      var lname = document.forms["form"]["lname"].value;
      console.log("lname == %s", lname);
      var lname_pattern = /^[A-Z][a-z]+$/; 
      var lname_ok = lname_pattern.test(lname);
      console.log(lname_ok ? "lname in pattern" : "lname NOT in pattern");

      var age = document.forms["form"]["age"].value;
      console.log("age == %s", age);
      var age_ok = 0 <= Number(age) && Number(age) <= 200 && age != "" ? true : false;
      console.log(age_ok ? "age in range" : "age NOT in range");
      
      var birth_month = document.forms["form"]["birth-month"].value;
      console.log("birth_month == %s", birth_month);
      var birth_month_ok =  birth_month == "January"    ||
                            birth_month == "February"   ||
                            birth_month == "March"      ||
                            birth_month == "April"      ||
                            birth_month == "May"        ||
                            birth_month == "June"       ||
                            birth_month == "July"       ||
                            birth_month == "August"     ||
                            birth_month == "September"  ||
                            birth_month == "October"    ||
                            birth_month == "November"   ||
                            birth_month == "December"   ?   true : false;
      console.log(birth_month_ok ? "birth month valid" : "birth month invalid");

      var birth_day = document.forms["form"]["birth-day"].value;
      birth_day = birth_day == "" ? undefined : String(Number(birth_day));
      console.log("birth_day == %s", birth_day);
      var birth_day_pattern = /^\d{1,2}$/;
      var birth_day_ok = birth_day_pattern.test(birth_day);
      console.log(birth_day_ok ? "birth day in pattern" : "birth day NOT in pattern");

      var birth_year = document.forms["form"]["birth-year"].value;
      birth_year = birth_year == "" ? undefined : String(Number(birth_year));
      console.log("birth_year == %s", birth_year);
      var birth_year_ok = 1800 <= Number(birth_year) && Number(birth_year) <= 2018 ? true : false;
      console.log(birth_year_ok ? "birth year in range" : "birth year NOT in range");

      var all_ok =  email_ok                    & 
                    password_ok                 & 
                    password_confirmation_ok    &
                    phone_number_ok             & 
                    fname_ok                    &
                    lname_ok                    &
                    age_ok                      &
                    birth_month_ok              &
                    birth_day_ok                &
                    birth_year_ok               ? true : false;      
      
       
      var form;

      let alertMessage = '';
      // TODO: Fill the alert message according to the validation result by following the form in README.md.
      
      if(all_ok)
          alertMessage += "Successfully Submitted!";
      else
          alertMessage += "You must correct:\n\n";
        

      if(!email_ok){
          alertMessage += "Email\n";
          document.getElementById("email-label").innerHTML = "X"
          document.getElementById("email-label").title = "characters@characters.domain (characters other than @ or whitespace followed by an @ sign, followed by more characters (not '@', '.', or whitespace: co.kr is not allowed in this case), and then a \".\". After the \".\", you can only write 2 to 3 letters from a to z).";
      }
      else{
          document.getElementById("email-label").innerHTML = "";
          document.getElementById("email-label").title = "";
      }

      if(!password_ok){              
          alertMessage += "Password\n";
          document.getElementById("password-label").innerHTML = "X";
          document.getElementById("password-label").title = "Must contain at least one number and one uppercase and one lowercase letter, and at least 8 or more characters.";
      }
      else{
          document.getElementById("password-label").innerHTML = "";
          document.getElementById("password-label").title = "";
      }

      if(!password_confirmation_ok){ 
          alertMessage += "Password Confirmation\n";
          document.getElementById("password-confirmation-label").innerHTML = "X";
          document.getElementById("password-confirmation-label").title = "Must match password.";
      }
      else{
          document.getElementById("password-confirmation-label").innerHTML = "";
          document.getElementById("password-confirmation-label").title = "";
      }

      if(!phone_number_ok){          
          alertMessage += "Phone number\n";
          document.getElementById("phone-number-label").innerHTML = "X";
          document.getElementById("phone-number-label").title = "nnn-nnnn-nnnn: three numbers, then \"-\", followed by four numbers and a \"-\", then four numbers.";
      }
      else{
          document.getElementById("phone-number-label").innerHTML = "";
          document.getElementById("phone-number-label").title = "";
      }

      if(!fname_ok){                 
          alertMessage += "First Name\n";
          document.getElementById("fname-label").innerHTML = "X";
          document.getElementById("fname-label").title = "Start with a capital letter, followed by one or more lowercase letters. Should only contain alphabets (A-Z, a-z)";
      }
      else{
          document.getElementById("fname-label").innerHTML = "";
          document.getElementById("fname-label").title = "";
      }

      if(!lname_ok){                 
          alertMessage += "Last Name\n";
          document.getElementById("lname-label").innerHTML = "X";
          document.getElementById("lname-label").title = "Start with a capital letter, followed by one or more lowercase letters. Should only contain alphabets (A-Z, a-z)";
      }
      else{
          document.getElementById("lname-label").innerHTML = "";
          document.getElementById("lname-label").title = "";
      }

      if(!age_ok){                   
          alertMessage += "Age\n";
          document.getElementById("age-label").innerHTML = "X";
          document.getElementById("age-label").title = "Must be a number between 0 and 200 (inclusive).";
      }
      else{
          document.getElementById("age-label").innerHTML = "";
          document.getElementById("age-label").title = "";
      }

      if(!birth_month_ok){           
          alertMessage += "Month\n";
          document.getElementById("birth-month-label").innerHTML = "X";
          document.getElementById("birth-month-label").title = "Must be one of \"January\", \"February\", ..., \"December\"";
      }
      else{
          document.getElementById("birth-month-label").innerHTML = "";
          document.getElementById("birth-month-label").title = "";
      }

      if(!birth_day_ok){             
          alertMessage += "Day\n";
          document.getElementById("birth-day-label").innerHTML = "X";
          document.getElementById("birth-day-label").title = "Must be a number of one or two digits.";
      }
      else{
          document.getElementById("birth-day-label").innerHTML = "";
          document.getElementById("birth-day-label").title = "";
      }

      if(!birth_year_ok){            
          alertMessage += "Year";
          document.getElementById("birth-year-label").innerHTML = "X";
          document.getElementById("birth-year-label").title = "Must be a number between 1800 and 2018 (inclusive).";
      }
      else{
          document.getElementById("birth-year-label").innerHTML = "";
          document.getElementById("birth-year-label").title = "";
      }

      alert(alertMessage);

      // Hint: you can use the RegExp class for matching a string with the `test` method.
      // Hint: you can set contents of elements by finding it with `document.getElementById`, and fixing the `innerHTML`.
      // Hint: modify 'title' attribute of each label to display your message
      // Hint: Ask Google to do things you don't know yet! There should be others who have already done what you are to encounter.
  };
  document.body.appendChild(but);
