import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  imports: [RouterLink],
  selector: 'app-historial-detalle',
  styleUrl: './historial-detalle.css',
  templateUrl: './historial-detalle.html',
})
export class HistorialDetalle {
  protected readonly actividad = 'Terminar ensayo';
  protected readonly ciclos = '3 de 3';
  protected readonly tiempoTotal = '1h 15m';
  protected readonly completa = true;
}
