import { Routes } from '@angular/router';
import { HistorialGeneral } from './pages/historial-general/historial-general';

export const routes: Routes = [
  { path: '', redirectTo: 'historial-general', pathMatch: 'full' },
  { path: 'historial-general', component: HistorialGeneral },
];
