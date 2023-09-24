import Debug "mo:base/Debug";
import Nat "mo:base/Nat";

//class for DBank
actor DBank{

  //var for current bank balance
  var currentValue = 30;

  //let vars remain constant throughout
  let id = 111212121;

  //print comments
  Debug.print("Hello from DBank");

  
  //topUp took care of adding money to account
  //if made public => can be accessed from anywhere cmd line
  //providing amount to add Nat= Natural Number
  public func topUp(amount: Nat)
  {
    currentValue += amount;
    //print currentValue
    Debug.print(debug_show(currentValue));
  };
  //if topUp is not public then use function name to call
  // topUp();

  //withdraw function for withdrawl of money from account
  public func withdraw(amount : Nat)
  { 
    let tempVal: Int = currentValue - amount;
    if(tempVal >= 0)
    { 
      currentValue -= amount;
      //print currentValue
      Debug.print(debug_show(currentValue)); 
    }
    else{
      Debug.print("Not sufficient balance");
    }
  };

  // topUp and withdraw are Update calls and they are updating the state of 
  // canister => take more amount to call 

  //query calls are used to operate on current state of canister without changing it
  //if returning make it asynchronus => independent of other function to load up  
  public query func checkbalance() : async Nat
  {   
      //read only operation
      return currentValue;
  };


}