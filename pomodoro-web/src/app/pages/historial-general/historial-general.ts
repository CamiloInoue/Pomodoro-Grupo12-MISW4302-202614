import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

export interface SesionHistorial {
  readonly fecha: string;
  readonly actividad: string;
  readonly duracion: string;
  readonly completa: boolean;
}

@Component({
  imports: [RouterLink],
  selector: 'app-historial-general',
  styleUrl: './historial-general.css',
  templateUrl: './historial-general.html',
})
export class HistorialGeneral {
  protected readonly periodos = ['Esta semana', 'Este mes', 'Todo'];
  protected readonly actividades = [
    'Todas',
    'Terminar ensayo',
    'Estudiar Cálculo',
    'Leer capítulo 4',
  ];

  /** Actividad de ejemplo sobre la que se ofrece el historial filtrado. */
  protected readonly actividadDestacada = 'Terminar ensayo';

  protected readonly sesiones: readonly SesionHistorial[] = [
    { fecha: 'Lun 18 Ago', actividad: 'Terminar ensayo', duracion: '50 min', completa: true },
    { fecha: 'Mar 19 Ago', actividad: 'Estudiar Cálculo', duracion: '25 min', completa: true },
    { fecha: 'Mié 20 Ago', actividad: 'Leer capítulo 4', duracion: '32 min', completa: false },
  ];
}
