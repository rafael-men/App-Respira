enum ObjetivoUso { alivio, acompanhamento, ambos }
enum FrequenciaRegistro { diaria, semanal, quandoPrecisar }

class PreferenciasUsuario {
  ObjetivoUso? objetivo;
  FrequenciaRegistro? frequencia;
  bool? receberLembretes;
}
