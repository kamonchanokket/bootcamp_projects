# Bulid Chatbot Pizza by R

print("Welcome to BINGO PIZZA!")
print("===========================")

cat("What's your name: ")
user_name <- readLines("stdin",n=1)
print(paste("Hi",user_name,". Would you like to order pizza? (Y/N) : "))
cat("Enter answer: ")
ans_order <- as.character(readLines("stdin",n=1))


if(ans_order == "Y" || ans_order == "y"){

  #select pizza size 
  cat("\n==========Size Menu========\n")

  size = c("Small","Medium","Large")
  price = c(199,399,599)
  
  pizza_menu_df <- data.frame(size,price)
  print(pizza_menu_df)
  cat("\n")
  cat("Please select a number(1-3) to select a pizza size: ")
  size_order <- as.numeric(readLines("stdin",n=1))

  #select crust
  
  cat("\n=========Crust Menu=========\n")
  cat("1.Pan\n2.Extreame Cheese Crust  +60 ฿\n3.Extreame sausage & Cheese Crust  +100 ฿\n")
  crust = c("Pan","Extreame Cheese","Extreame sausage & Cheese")
  p_crust = c(0,60,100)
  cat("\n")
  cat("Please select a number(1-3) to select a pizza crust: ")
  crust_order <- as.numeric(readLines("stdin",n=1))

  #select flavour
  cat("\n=========Flavour Menu=========\n")
  cat("1.Seafood Cocktail\n2.Cheese & Bacon\n3.Hawaiian\n4.Meat Deluxe\n5.Chicken Trio\n6.Tom Yum Kung")
  cat("\n")
  
  flavour = c("Seafood Cocktail","Cheese & Bacon","Hawaiian","Meat Deluxe","Chicken Trio","Tom Yum Kung")
  cat("\nPlease select a number(1-6) to select a pizza flavour: ")
  flavour_order <- as.numeric(readLines("stdin",n=1))

  #select Anything else
  cat("Do you want anything else? (Y/N):")
  any_answer <- as.character(readLines("stdin",n=1))

  if(any_answer == "Y" || any_answer == "y"){
    cat("\n=========Menu=========\n")
    menu = c("BBQ Chicken","BBQ Pork Ribs","Pasta","Caesar Salad")
    price_menu = c(139,359,129,149)
    other_menu_df <- data.frame(menu,price_menu)
    print(other_menu_df)
    cat("\nPlease select a number(1-4) to select anything menu: ")
    any_order <- as.numeric(readLines("stdin",n=1))
  }else{
    menu <- c("-")
    price_menu <- c(0)
    any_order <- 1
  }

  #Select delivery type
  deli_type <- c("Pickup", "Standard +40฿", "Express +100฿")
  deli_price <- c(0, 40, 100)
  
  cat("\n=========Delivery type=========\n")
  delivery_type_df <- data.frame(deli_type,deli_price)
  cat("\nPlease select a number(1-3) to select a delivery type: ")
  deli_order <- as.numeric(readLines("stdin",n=1))

  if(deli_order == 1){ 
    cat("You pick up at the BINGO PIZZA!\n")
    address_user <- "-"
    cat("\nPlease enter your phone number\nPhone number :")
    phone_number <- readLines("stdin",n=1)
    } else{
     cat("\nPlease enter your address\nAddress :")
     address_user <- readLines("stdin",n=1)
     cat("\nPlease enter your phone number\nPhone number :")
     phone_number <- readLines("stdin",n=1)
  }
   total_price <- price[size_order] + p_crust[crust_order] + price_menu[any_order] + deli_price[deli_order]
#print payment
  cat(c(" ","=======BINGO PIZZA========"," ",
    paste("Customer: ",user_name),
    paste("Pizza Size :",size[size_order]," ",price[size_order]),
    paste("Pizza Crust:",crust[crust_order]," ",p_crust[crust_order]),
    paste("Flavour:",flavour[flavour_order]),
    paste("Other menu: ",menu[any_order],price_menu[any_order]),   
    paste("Total Price",total_price,"Baht")," ", 
    "==========================",
    paste("Delivery: ",deli_type[deli_order],deli_price[deli_order]), 
    paste("Address: ",address_user),
    paste("Phone Number: ",phone_number),
    " ",
    "=========Thank You========"
       ),sep = "\n"
    )
  
}
  
