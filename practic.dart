abstract class Vehicle{
    void move();
}

class Car extends Vehicle{
    String? brand;
    String? model;
    int? year;
    Car({this.brand, this.model, this.year});
    void displayInfo(){
        print('Car brand: $brand');
        print('Car model: $model');
        print('Car year: $year');
    }
    @override
    void move(){
        print('Машина едет по дороге');
    }
}

class ElectricCar extends Car{
    int? batteryCapacity;
    ElectricCar({brand, model, year, this.batteryCapacity}) : super(brand: brand, model: model, year: year);
    @override
    void displayInfo(){
        super.displayInfo();
        print('Battery capacity: $batteryCapacity');
    }
    @override
    void move(){
        print('Электромобиль едет бесшумно');
    }
}

void main(){
    Car car = Car(brand: 'Toyota', model: 'Corolla', year: 2015);
    car.displayInfo();
    car.move();
    print('-------------------');
    ElectricCar electricCar = ElectricCar(brand: 'Tesla', model: 'Model S', year: 2020, batteryCapacity: 100);
    electricCar.displayInfo();
    electricCar.move();
}