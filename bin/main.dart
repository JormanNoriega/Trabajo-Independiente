import 'user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUsers() async {
  final respuesta = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (respuesta.statusCode == 200) {
    List<dynamic> datos = json.decode(respuesta.body);
    return datos.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Error al cargar los usuarios');
  }
}

// Filtra los usuarios cuyo username tiene más de 6 caracteres
List<User> filtrarLongitudNombre(List<User> usuarios) {
  return usuarios.where((usuario) => usuario.username.length > 6).toList();
}

// Cuenta los usuarios cuyo email tiene el dominio 'biz'
int contarEmailBiz(List<User> usuarios) {
  return usuarios.where((usuario) => usuario.email.endsWith('.biz')).length;
}

void main() async {
  try {
    List<User> usuarios = await fetchUsers();
    // Filtrar usuarios con username > 6 caracteres
    List<User> usuariosFiltrados = filtrarLongitudNombre(usuarios);
    print('Usuarios con nombre de usuario de más de 6 caracteres:');
    for (var usuario in usuariosFiltrados) {
      print('- ${usuario.username}');
    }
    // Contar usuarios con email de dominio 'biz'
    int cantidadDominioBiz = contarEmailBiz(usuarios);
    print('\nCantidad de usuarios con email de dominio ".biz": $cantidadDominioBiz');
  } catch (e) {
    print('Error: $e');
  }
}

