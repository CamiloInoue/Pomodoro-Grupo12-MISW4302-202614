import { Location } from '@angular/common';
import { Component, inject } from '@angular/core';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { SESIONES_MOCK } from '../historial-general/historial-general';

@Component({
  imports: [RouterLink],
  selector: 'app-historial-filtrado',
  styleUrl: './historial-filtrado.css',
  templateUrl: './historial-filtrado.html',
})
export class HistorialFiltrado {
  private readonly location = inject(Location);
  private readonly route = inject(ActivatedRoute);

  protected goBack(): void {
    this.location.back();
  }

  protected readonly actividad =
    this.route.snapshot.queryParamMap.get('actividad') ?? 'Terminar ensayo';

  protected readonly sesiones = SESIONES_MOCK.filter(
    (sesion) => sesion.actividad === this.actividad,
  );
}
