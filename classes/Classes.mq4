#property copyright "Copyright © 2019-2021 Artem Maltsev (Vivazzi)"
#property link      "https://vivazzi.pro"
#property strict


class Employee {
public:
    string name;
    string post;

    Employee(){};

    Employee(string _name, string _post) {
        name = _name;
        post = _post;
    };

    Employee::Employee(const Employee &_employee) {
        name = _employee.name;
        post = _employee.post;
    }
};


class Company {
public:
    Employee employees[];

    void set_employees(Employee &_employees[]){
        ArrayResize(employees, ArraySize(_employees));
        for (int i=0; i < ArraySize(employees); i++) {
            employees[i] = _employees[i];
        }
    }

    void add_employee(Employee &_employee){
        ArrayResize(employees, ArraySize(employees) + 1);
        employees[ArraySize(employees) - 1] = _employee;
    }

    void add_employee(string name, string post){
        ArrayResize(employees, ArraySize(employees) + 1);
        employees[ArraySize(employees) - 1] = Employee(name, post);
    }

    Employee get_employee_by_post(string post) {
        for (int i=0; i < ArraySize(employees); i++) {
            if (employees[i].post == post) return employees[i];
        }
        return Employee();
    }

    Employee get_director() {
        return get_employee_by_post("Director");
    }

    int employee_number() {
        return ArraySize(employees);
    }

    string display_employees() {
        string res = "";

        for (int i=0; i < ArraySize(employees); i++) {
            res += employees[i].name;
            if (i <  ArraySize(employees) - 1) res += ", ";
        }

        return res;
    }
};


int OnInit(){
    Company company;

    Employee employees[2];
    employees[0] = Employee("Alla", "Manager");
    employees[1] = Employee("Bella", "Manager");
    company.set_employees(employees);


    Employee nataly("Nataly", "Manager");
    company.add_employee(nataly);


    company.add_employee("Mike", "Director");
    company.add_employee("Denis", "Designer");

    Print("Number of employees is " + (string)company.employee_number() + ": " + company.display_employees());

    Print("Director name is " + company.get_director().name);

    Employee dancer;
    dancer = company.get_employee_by_post("Dancer");
    if (dancer.name != NULL) Print("Dancer name is " + dancer.name);
    else Print("There is not dancer in company");

	return(INIT_SUCCEEDED);
}