import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import { now } = "mo:base/Time";
import Time "mo:base/Time";
import Float "mo:base/Float";

//class for DBank
actor DBank{

  //var for current bank balance
  // current Value is a stable => orthogonal persistant var => it 
  //will remember it's state
  stable var currentValue: Float = 50;
  currentValue := 40;
  //let vars remain constant throughout
  let id = 111212121;

  //print comments
  Debug.print("Hello from DBank");

  
  //topUp took care of adding money to account
  //if made public => can be accessed from anywhere cmd line
  //providing amount to add Nat= Natural Number
  public func topUp(amount: Float)
  {
    currentValue += amount;
    //print currentValue
    Debug.print(debug_show(currentValue));
  };
  //if topUp is not public then use function name to call
  // topUp();

  //withdraw function for withdrawl of money from account
  public func withdraw(amount : Float)
  { 
    let tempVal: Float = currentValue - amount;
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
  public query func checkbalance() : async Float
  {   
      //read only operation
      return currentValue;
  };

  //get nanosec since 1971 till now
  stable var startTime = Time.now();
  startTime := Time.now();

  //give the amount earned by consumer with 1% intrest per/sec
  public func compund()
  {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime; // time elaplse in seconds
    let timeElapsedS = timeElapsedNS / 10000000000; // time elapse in seconds

    let time_ = (1.01 * Float.fromInt(timeElapsedS));
    currentValue := currentValue * time_;
    startTime := currentTime; // change start time to current time each time 
  }
}