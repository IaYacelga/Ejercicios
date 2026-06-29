#include <iostream>
#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <bsoncxx/builder/stream/document.hpp>
#include <bsoncxx/json.hpp>

int main() {
    mongocxx::instance inst{};
    mongocxx::client client{mongocxx::uri{"mongodb://localhost:27017"}};
    
    mongocxx::database db = client["visual"];
    mongocxx::collection col = db["clientes"];
    
    // Crear documento
    auto doc = bsoncxx::builder::stream::document{}
        << "nombre" << "Ivan Andres"
        << "email" << "ivan@example.com"
        << "edad" << 25
        << bsoncxx::builder::stream::finalize;
    
    // Insertar
    auto result = col.insert_one(doc.view());
    
    std::cout << "Documento insertado con ID: " 
              << result->inserted_id().get_oid().value.to_string() 
              << std::endl;
    
    return 0;
}