// Importing required Java packages
import java.util.List;

/**
 * Java 17 Important Features
 */
public class JavaNewFeaturesDemo {

    public static void main(String[] args) {
        // Demonstrating sealed classes
        // Sealed classes allow you to control which classes can extend them
        // Here, Shape is a sealed class and Circle and Rectangle are permitted subclasses
        Shape shape = new Circle(5);
        System.out.println("Area of the shape: " + shape.calculateArea());

        // Demonstrating pattern matching for switch
        // Pattern matching allows you to use the type of the object in the switch statement
        printShapeType(shape);
        printShapeType(new Square(0));

        // Demonstrating text blocks
        String json = """ 
                {
                    "name": "Java 17",
                    "features": ["Sealed Classes", "Pattern Matching", "Text Blocks"]
                }
                """;
        System.out.println("Text Block Example: " + json);
    }

    /**
     * Method to demonstrate pattern matching for switch
     */
    private static void printShapeType(Shape shape) {
        switch (shape) {
            case Circle c -> System.out.println("This is a Circle with radius: " + c.getRadius());
            case Rectangle r -> System.out.println("This is a Rectangle with width: " + r.getWidth() + " and height: " + r.getHeight());
            default -> System.out.println("Unknown Shape");
        }
    }

    // Sealed class example
    private static sealed abstract class Shape permits Circle, Rectangle, Square {
        public abstract double calculateArea();
    }

    private static final class Square extends Shape {
        private final double _side;

        public Square(double side) {
            this._side = side;
        }

        public double getSide() {
            return _side;
        }

        @Override
        public double calculateArea() {
            return _side * _side;
        }
    }

    // Circle class extending Shape
    private static final class Circle extends Shape {
        private final double _radius;

        public Circle(double radius) {
            this._radius = radius;
        }

        public double getRadius() {
            return _radius;
        }

        @Override
        public double calculateArea() {
            return Math.PI * _radius * _radius;
        }
    }

    // Rectangle class extending Shape
    private static final class Rectangle extends Shape {
        private final double _width;
        private final double _height;

        public Rectangle(double width, double height) {
            this._width = width;
            this._height = height;
        }

        public double getWidth() {
            return _width;
        }

        public double getHeight() {
            return _height;
        }

        @Override
        public double calculateArea() {
            return _width * _height;
        }
    }
}