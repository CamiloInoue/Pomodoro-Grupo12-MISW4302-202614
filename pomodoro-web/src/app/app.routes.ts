import { Routes } from '@angular/router';
import { HistorialDetalle } from './pages/historial-detalle/historial-detalle';
import { HistorialFiltrado } from './pages/historial-filtrado/historial-filtrado';
import { HistorialGeneral } from './pages/historial-general/historial-general';

export const routes: Routes = [
  { path: '', redirectTo: 'historial-general', pathMatch: 'full' },
  { path: 'historial-general', component: HistorialGeneral },
  { path: 'historial-filtrado', component: HistorialFiltrado },
  { path: 'historial-detalle', component: HistorialDetalle },
];
