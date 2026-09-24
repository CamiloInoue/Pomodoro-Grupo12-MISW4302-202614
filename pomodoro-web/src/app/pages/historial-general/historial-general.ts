import { Location } from '@angular/common';
import { Component, inject } from '@angular/core';
import { RouterLink } from '@angular/router';

export interface SesionHistorial {
  readonly fecha: string;
  readonly actividad: string;
  readonly duracion: string;
  readonly completa: boolean;
}

/** Fuente única de sesiones de ejemplo, compartida con historial-filtrado. */
export const SESIONES_MOCK: readonly SesionHistorial[] = [
  { fecha: 'Lun 18 Ago', actividad: 'Terminar ensayo', duracion: '50 min', completa: true },
  { fecha: 'Mar 19 Ago', actividad: 'Estudiar Cálculo', duracion: '25 min', completa: true },
  { fecha: 'Mié 20 Ago', actividad: 'Leer capítulo 4', duracion: '32 min', completa: false },
  { fecha: 'Jue 21 Ago', actividad: 'Terminar ensayo', duracion: '1h 05min', completa: true },
];

@Component({
  imports: [RouterLink],
  selector: 'app-historial-general',
  styleUrl: './historial-general.css',
  templateUrl: './historial-general.html',
})
export class HistorialGeneral {
  private readonly location = inject(Location);

  protected goBack(): void {
    this.location.back();
  }

  protected readonly periodos = ['Esta semana', 'Este mes', 'Todo'];
  protected readonly actividades = [
    'Todas',
    'Terminar ensayo',
    'Estudiar Cálculo',
    'Leer capítulo 4',
  ];

  protected readonly sesiones = SESIONES_MOCK;
}
