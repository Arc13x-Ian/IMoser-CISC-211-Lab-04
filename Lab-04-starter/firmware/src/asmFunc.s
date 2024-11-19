/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Ian Moser"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align


    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
        
    MOV r1, 0
    
    LDR r2, =eat_out
    STR r1, [r2]
    LDR r2, =stay_in
    STR r1, [r2]
    LDR r2, =eat_ice_cream
    STR r1, [r2]
    LDR r2, =we_have_a_problem
    STR r1, [r2]
    LDR r2, =transaction
    STR r0, [r2]
    /* This loads each variable's address into register 2, then puts zero into
     that variable's register. (except transaction, which has r0's number.
     This way, there won't be trash numbers left in the spots needed for the 
     variables.*/
     
    CMP r0, 1000
    BGT ohNo
    
    CMP r0, -1000
    BLT ohNo
    /* checks if the transaction is within range, sending it to the oh No zone
     if range is exceeded */
    
    
    LDR r3, =balance
    LDR r5, [r3]
    
    tmpBalance: ADDS r4, r0, r5
    BVS ohNo
    STR r4,[r3]
     /* creates the temp balance variable, which is transaction (in r0) and 
     balance added. And if it overflows, oh no it. If it doesn't overflow,
     we turn the temp balance into our new balance */
    
    CMP r4, 0
    BGT eatOut
    BLT stayIn
    BEQ iceCream
    /* check if balance is positive, negative, or zero, and send the code
     to the appropriate branch, which will turn on the right flag, then wrap
     up the program. */
    
    
    
ohNo:
    
    LDR r2, =transaction
    MOV r1, 0
    STR r1, [r2]
    
    LDR r2, =we_have_a_problem
    MOV r1, 1
    STR r1, [r2]
    
    LDR r2, =balance
    LDR r0, [r2]
    
    BAL done
    
eatOut:
    
    LDR r2, =eat_out
    MOV r1, 1
    STR r1, [r2]
    BAL wrapUp
    
stayIn:
    
    LDR r2, =stay_in
    MOV r1, 1
    STR r1, [r2]
    BAL wrapUp
    
iceCream:
    
    LDR r2, =eat_ice_cream
    MOV r1, 1
    STR r1, [r2]
    BAL wrapUp
    
wrapUp:
    
    LDR r0, [r3]
    BAL done
    
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




