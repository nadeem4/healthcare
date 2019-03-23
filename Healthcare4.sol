pragma solidity ^0.4.25;

contract Healthcare4 {
    address public InstanceMedicalProfessional;
    address public InstanceSchedulingPersonal;
    address public InstancePayor;
    address public InstancePatient;

    bool public isPatientIdentityDenied = false;

    enum StateType {
        Ordered,
        IdentityUpdated,
        Received,
        PatientIdentityRequested,
        PatientIndentityConfirmed,
        PatientIndentityDenied,
        CoverageOrEligibilityRequested,
        ConverageOrEligibilityProvided,
        AuthorizationRequested,
        AuthorizationApproved,
        FinancialResponsibilityCommunicated,
        PatientRegistered,
        PaymentOutstanding,
        PaymentCollected
        
    }
    StateType public State;

    string public firstName;
    string public lastName;
    string public dob;
    uint public responisibilityAmount;
    string public email;
    uint public responsibiltyAmountCollected;
    
    enum ProcedureOrdered {
        MRI,
        CAT_scan,
        X_RAY,
        Blood_Work
    }
    ProcedureOrdered public procedureOrdered;

    modifier onlyMedicalProfessional() {
        require(InstanceMedicalProfessional == msg.sender);
        _;
    }
    modifier onlySchedulingPersonal() {
        require(InstanceSchedulingPersonal == msg.sender);
        _;
    }

    modifier onlyPayor() {
        require(InstancePayor == msg.sender);
        _;
    }

    modifier onlyPatient() {
        require(InstancePatient == msg.sender);
        _;
    }

    constructor(address _schedulingPersonal, address _payor, address _patient, string _firstName, string _lastName, string _dob, string _email, ProcedureOrdered _procedureOrdered) public {
        InstanceMedicalProfessional = msg.sender;
        InstanceSchedulingPersonal = _schedulingPersonal;
        InstancePayor = _payor;
        InstancePatient = _patient;
        firstName = _firstName;
        lastName = _lastName;
        dob = _dob;
        email = _email;
        procedureOrdered = _procedureOrdered;
        State = StateType.Ordered;
    }

    function updateIdentity( string _firstName, string _lastName, string _dob ) public  onlySchedulingPersonal{
        require(isPatientIdentityDenied == true);
        firstName = _firstName;
        lastName = _lastName;
        dob = _dob;
        State = StateType.IdentityUpdated;
    }

    function receive() public onlySchedulingPersonal{
        State = StateType.Received;
    }

    function requestpatientIdentity() public onlySchedulingPersonal{
        State = StateType.PatientIdentityRequested;
    }

    function confirmPatientIdentity() public onlyPayor{
        State = StateType.PatientIndentityConfirmed;
    }

    function denyPatientIdentity( ) public onlyPayor {
        State = StateType.PatientIndentityDenied;
    }

    function requestCoverage() public onlySchedulingPersonal{
        if( State == StateType.PatientIndentityConfirmed) {
            State = StateType.CoverageOrEligibilityRequested;
        } else {
            isPatientIdentityDenied = true;
            State = StateType.Ordered;
        }
        
    }

    function returnCovergaeDetails() public onlyPayor {
        State = StateType.ConverageOrEligibilityProvided;
        checkForMedicalNecessity();
    }

    function checkForMedicalNecessity()public {
       // State = StateType.CheckingMedicalNecessity;
    }
    function requestAuthorization() public onlySchedulingPersonal {
        State = StateType.AuthorizationRequested;
        validateMedicalNecessity();
    }

    function validateMedicalNecessity()public {
        //State = StateType.MedicalNecessityValidated;
    }

    function approveAuthorization() public onlyPayor {
        State = StateType.AuthorizationApproved;
    }

    function communicateFinancialResponsibility( uint _responisibilityAmount) public onlySchedulingPersonal{
        responisibilityAmount = _responisibilityAmount;
        State = StateType.FinancialResponsibilityCommunicated;
    }

    function registerPatient() public  onlyPatient{
        State = StateType.PatientRegistered;
    }

    function collectPayment( uint _amountCollected) public onlySchedulingPersonal {
        responsibiltyAmountCollected = responsibiltyAmountCollected + _amountCollected;
        require( responisibilityAmount >= responsibiltyAmountCollected);
        if(responsibiltyAmountCollected == responisibilityAmount) {
            State = StateType.PaymentCollected;
        } else {
            State = StateType.PaymentOutstanding;
        }
    }
}