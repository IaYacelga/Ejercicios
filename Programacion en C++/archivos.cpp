#include <iostream>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>

int main() {
    mongocxx::instance inst{};
    mongocxx::client client{mongocxx::uri{"mongodb://localhost:27017"}};
    
    mongocxx::database db = client["visual"];
    
    std::cout << "Conectado a MongoDB - base de datos: visual" << std::endl;
    
    return 0;
}