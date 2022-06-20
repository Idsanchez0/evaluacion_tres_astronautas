class GifsModel{
  var id, lugar, nombre, fecha, supervisor, hora, novedad, responsable, solucion, estado;
  GifsModel(this.id, this.lugar, this.fecha, this.supervisor, this.hora, this.novedad, this.responsable, this.solucion, this.estado);

  GifsModel.fromJson(Map<String, dynamic> json){
    id = json['encidIncidencias'];
    lugar = json['lugar'];
    nombre = json['nombre'];
    fecha = json['fecha'];
    supervisor = json['supervisor'];
    hora = json['hora'];
    novedad = json['novedad_generada'];
    responsable = json['responsable'];
    solucion = json['se_soluciono'];
    estado = json['estado_incidencia'];
  }
}