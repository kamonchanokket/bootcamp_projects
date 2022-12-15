# build pao ying chub game by R
# User play unlimited times

# greeting 
print("  Welcome to PAO YING CHUB GAME 2022  ")
print("======================================")
cat("Enter Your Name : ")
player_name <- readLines(con="stdin",n=1)
print(paste("Hello ",player_name))
cat("Press P to start playing the PAO YING CHUB GAME 2022 or Press X to exit game\nEnter : ")

#Before Start pao ying chub game 2022
  while(TRUE){
    p_start <- readLines(con="stdin",n=1)
      if(p_start == "P") {
        break
      }else if (p_start == "X") {
        print("Thank you for coming to play games with us.")
        break
      }else{
        print("Try again ! Press P or X only :")
      }
  }  

#variable 
win_cnt <- 0
lose_cnt <- 0
tie_cnt <- 0
play_total <- 0
error_cnt <- 0 

#Start Game 
 while(p_start == "P"){
    print ("Game start!")
    play_total <- play_total+1  #count playgame
        
  #User Seclcted & Check input character  
   while(TRUE){
    print("Please select your number for pao ying chub")
    cat("1.Rock\n2.Paper\n3.Scissors\nEnter:")
    user_select <- readLines(con="stdin",n=1)
     
      if(user_select == "1"|| user_select == "2"|| user_select =="3"){
        user_select <- as.numeric(user_select)
        break
        
      }else{
        print ("Your input does not exist") 
        error_cnt <- error_cnt+1
      }
   }
   
    choice <- c("Rock","Paper","Scissors")
    print(paste("Your Shoot : ",choice[user_select]))
   
    #Bot Randoms
    bot_select <- sort(sample.int(3, 1))
    print(paste("Bot Shoot : ",choice[bot_select]))

    #check condition 
   if(user_select == 1 && bot_select == 1 || 
      user_select == 2 && bot_select == 2 ||
      user_select == 3 && bot_select == 3){
      print("You tie")
      tie_cnt <- tie_cnt+1
     
   }else if( user_select == 1 && bot_select == 2 ||
             user_select == 2 && bot_select == 3 ||
             user_select == 3 && bot_select == 1){
      print("You Lose. Keep fighting!! ")
      lose_cnt <- lose_cnt+1
     
   }else if( user_select == 3 && bot_select == 2 ||
             user_select == 2 && bot_select == 1 ||
             user_select == 1 && bot_select == 3){
      print("You Win. THAT’S HOT!! ")
      win_cnt <- win_cnt+1
     
   }
     
  #Play Again
    print("Do you wanna play again? Please press P or press any key to exit game ")
    p_start <- readLines(con="stdin",n=1)
          
}
print("========= This is Your Score ===========")
print(paste("Play Total: ",play_total))
print(paste("Win Total: ",win_cnt))
print(paste("Tie Total: ",tie_cnt))
print(paste("Lose Total: ",lose_cnt))
print(paste("Error Your Input: ",error_cnt))
print(paste("========= Good Bye",player_name ,"==========="))
