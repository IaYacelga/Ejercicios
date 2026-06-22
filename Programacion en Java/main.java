public class main {
    public static void main(String[] args) {
        System.out.println("Hola Mundo!");

        // Variables
        String nombre = "Ivan";
        int edad = 20;
        double nota = 9.5;

        System.out.println("Nombre: " + nombre);
        System.out.println("Edad: " + edad);
        System.out.println("Nota: " + nota);

      
        if (nota >= 7) {
            System.out.println("Aprobado!");
        } else {
            System.out.println("Reprobado!");
        }

        // Bucle
        for (int i = 1; i <= 5; i++) {
            System.out.println("Numero: " + i);
        }
    }
}