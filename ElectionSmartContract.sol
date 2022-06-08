// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

//This is the test task of Election Smart Contract.
// You want hold free and fair Election for a specified amount of time and only authorised people to vote in it including these things
// Set the timestamp of the of the start of voting
// Return the number of voting registered
// Set the account that represents the poll worker control
// Record the elector identification number
// Enable if the elector hasn’t already voted previously
// Record the vote 1 for candidate A, 2 for candidate B, 3 for blank and other for null
// Set the end timestamp of the vote
// Return the end vote registered

contract ElectionSmartContract {

    
    constructor(){
        owner = msg.sender;
    }

    address public owner;
    string public lastVote;
    bool public isOpenForVoting;
        

    uint public startTime;
    uint public endTime;
    uint candidateA = 1;
    uint candidateB = 2;
    uint blank =3;


    uint public CandidateA;
    uint public CandidateB;
    uint public CandidateBlank;
    uint public notCandidate;
    uint[] registerVoter;
    

    mapping(uint=>bool) public Authorized;
    mapping(uint => bool) public Vote;



   //Opening Time for voting
    function openTimeForVoting() public  {
        startTime = block.timestamp;
        isOpenForVoting = true;
        
    }

    //Closing Time for voting
    function closingTimeForVoting() public {
        endTime = block.timestamp;
        isOpenForVoting = false;
    }

    //-----------------Authorized for voting----------------
    function authorized(uint _id) public  onlyOwner {
        
         require(isOpenForVoting,"you can authorized after starting the time!");
      

        Authorized[_id] = true;
        registerVoter.push(_id);
  
            
    }

    //---------------------All register for Voting---------------------------- 
    function registerForVoting() public view returns(uint256 registerVoters) {
        
        uint _registerVoters;
        
        for(uint i=0; i< registerVoter.length; i++){
                
                _registerVoters = registerVoter.length;
         
        }
        
        return _registerVoters;
    }

 
    //-----------------Modifier for Verifications----------------
    modifier alreadyVoted(uint _id)   {

        require(Vote[_id] == false,"Already voted" );
       
        _;
        
    }

    modifier isAuth(uint _id){
        require(Authorized[_id] , " Not authorized");
        _;
    }

    modifier onlyOwner(){
        require(owner==msg.sender,"Only Owner can Changes these functionalities!");
        _;
    }


    //Voting Functionality

    function candidates(string memory _n) internal{
        lastVote = _n;
    }

    function voting(uint _id,uint _candidate) isAuth(_id) alreadyVoted(_id) onlyOwner  public {
        
        
        require(isOpenForVoting,"Should be opening for voting!");
       
        
        if(_candidate == 1){

            
            CandidateA++;
             candidates("vote for Candidate A");
        }else if (_candidate == 2){
            
            CandidateB++;
             candidates("vote for Candidate B");
        }else if (_candidate == 3){
            
            CandidateBlank++;
             candidates("vote for candidate C");
        }else {

            notCandidate++;
            
             candidates("You entered for voting not a candidate exist");
        }

        Vote[_id] = true;
        
        


    }

    function outcomeVoting() public view  returns(uint candidateA,uint candidateB,uint candidateBlank,uint notCandidate){
        require(isOpenForVoting == false, "Please wait for end time of voting");
        return(CandidateA,CandidateB,CandidateBlank,notCandidate);
    }


}