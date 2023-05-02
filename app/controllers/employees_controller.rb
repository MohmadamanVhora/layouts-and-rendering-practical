class EmployeesController < ApplicationController
  before_action :find_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.all    
  end

  def show; end

  def new
    @employee = Employee.new
    @address = Address.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end
  
  def update
    if @employee.update(employee_params)
      redirect_to @employee
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @employee.destroy
    redirect_to employees_path
  end

  def search
    @employees = Employee.where("lower(name) LIKE ?", "%#{params[:query].downcase}%")
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email, :password, :gender , :mobile_number, :birth_date, :document, :hobby_ids, addresses_attributes: [:house_name, :street_name, :road])
  end

  def find_employee
    @employee = Employee.find(params[:id])
  end
end
