import { eventNames } from "process";
import {dbank_backend} from "../../declarations/dbank_backend"

window.addEventListener("load" , async function()
{
    update();
});

document.querySelector("form").addEventListener("submit" , async function()
{
    event.preventDefault();

    const button = event.target.querySelector("#submit-btn");

    const inputAmount = parseFloat(document.getElementById("input-amount").value);
    const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);


    button.setAttribute("disabled" , true);
    
    //top up amount only when valid input applied
    if(document.getElementById("input-amount").value.length != 0)
    {
        await dbank_backend.topUp(inputAmount);
    }

    //withdraw amount only when valid input applied
    if(document.getElementById("withdrawal-amount").value.length != 0)
    {   
        await dbank_backend.withdraw(outputAmount);
    }

    //each time value added or withdrawal add compound to it
    await dbank_backend.compund();

    update();

    document.getElementById("input-amount").value = "";
    document.getElementById("withdrawal-amount").value = "";
    button.removeAttribute("disabled" , true);
});


//checks balance everytime site loads
async function update()
{
    const currentAmount = await dbank_backend.checkbalance();
    document.getElementById("value").innerText = " " +  Math.round(currentAmount * 100) / 100;
}