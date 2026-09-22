import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { SesionHistorial } from '../historial-general/historial-general';

@Component({
  imports: [RouterLink],
  selector: 'app-historial-filtrado',
  styleUrl: './historial-filtrado.css',
  templateUrl: './historial-filtrado.html',
})
export class HistorialFiltrado {
  protected readonly actividad = 'Terminar ensayo';

  protected readonly sesiones: readonly SesionHistorial[] = [
    { fecha: 'Lun 18 Ago', actividad: 'Terminar ensayo', duracion: '50 min', completa: true },
    { fecha: 'Jue 21 Ago', actividad: 'Terminar ensayo', duracion: '1h 05min', completa: true },
  ];
}
