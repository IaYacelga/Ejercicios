#include <iostream>
#include <fstream>
#include <string>
using namespace std; 


int main(void){


    ofstream nombres("nombres.txt"); 

    if(!nombres.is_open()){
        cout << "Error al abrir el archiv" << endl; 
        return 1; 
    }
    

   nombres << "IVAN ANDRES YACELGA MALITAXI" << endl; 
   nombres.close(); 


    return 0;
}