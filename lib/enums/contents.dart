// ignore_for_file: lines_longer_than_80_chars
import 'package:testudines_solfago/enums/languages.dart';

enum Contents {
  intro,
  introQuestion,
  meteorCrash,
  superHot,
  superCold,
  tapToRetry,
  spawning,
  tapToReplay,
  loading,
  ;

  String get({int? eggsEaten}) {
    switch (this) {
      case Contents.intro:
        switch (language) {
          case Languages.es:
            return 'Testudines Solfago les han llamado.\nAntiguas civilizaciones les temían.\n¿Dioses devoradores de soles...';
          case Languages.en:
            return 'Testudines Solfago they been called.\nAncient civilations feared them.\nSun eating gods...';
        }
      case Contents.introQuestion:
        switch (language) {
          case Languages.es:
            return 'o simplemente criaturas en una eterna búsqueda de calor?';
          case Languages.en:
            return 'or merely creatures in an eternal quest for warmth?';
        }
      case Contents.meteorCrash:
        switch (language) {
          case Languages.es:
            return 'Flechado por un metero,\neste individuo cesa de ser,\ndejando atras un caparazón\nque deriva en el frio vacio del espacio';
          case Languages.en:
            return 'Pierced by a meteor,\nthis individual ceases to be,\nleaving behind a shell\nadrift in the cold void of space.';
        }
      case Contents.superCold:
        switch (language) {
          case Languages.es:
            return 'Conquistado por el gelido abrazo del vacio,\neste Testudines Solfago se apaga,\nlentamente el gigante\nse hunde en la oscuridad';
          case Languages.en:
            return 'Overcome by the icy embrace of the void,\nthis Testudines Solfago fades away,\nslowly the giant\nsinks into the darkness';
        }
      case Contents.superHot:
        switch (language) {
          case Languages.es:
            return 'En una ironia tragica\nel Testudines Solfago arde,\ny su forma se disuelve\nen un resplandor solar.';
          case Languages.en:
            return 'In a tragic irony,\nthe Testudines Solfago burns,\nand its form dissolves\ninto a solar glow.';
        }
      case Contents.spawning:
        switch (language) {
          case Languages.es:
            return 'En un ultimo acto de mortalidad,\nel Testudine Solfago desova $eggsEaten huevos,\nsin fuerzas restantes para continuar,\nse deja adormecer en el silencio del vacío';
          case Languages.en:
            return 'In a final act of mortality,\nthe Testudine Solfago lays $eggsEaten eggs,\nwith no remaining strength to continue,\nit surrenders to slumber in the silence of the void';
        }
      case Contents.tapToRetry:
        switch (language) {
          case Languages.es:
            return 'Manten presionada la pantalla o apreta la barria espaciadora para intentar de nuevo';
          case Languages.en:
            return 'Long press the screen or press the bar space to try again';
        }
      case Contents.tapToReplay:
        switch (language) {
          case Languages.es:
            return 'Manten presionada la pantalla o apreta la barria espaciadora para jugar de nuevo';
          case Languages.en:
            return 'Long press the screen or press the bar space to play again';
        }
      case Contents.loading:
        switch (language) {
          case Languages.es:
            return 'Estamos cargando las imagenes...';
          case Languages.en:
            return "We're loading the assets...";
        }
    }
  }
}
