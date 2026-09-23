import { Routes } from '@angular/router';
import { HistorialDetalle } from './pages/historial-detalle/historial-detalle';
import { HistorialFiltrado } from './pages/historial-filtrado/historial-filtrado';
import { HistorialGeneral } from './pages/historial-general/historial-general';
import { EnfoqueActivoComponent } from './pages/enfoque-activo/enfoque-activo';
import { DescansoComponent } from './pages/descanso/descanso';

export const routes: Routes = [
  { path: '', redirectTo: 'enfoque-activo', pathMatch: 'full' },
  { path: 'enfoque-activo', component: EnfoqueActivoComponent },
  { path: 'descanso', component: DescansoComponent },
  //{ path: 'modal-confirmar', component: ModalConfirmarComponent },
  { path: 'historial-general', component: HistorialGeneral },
  { path: 'historial-filtrado', component: HistorialFiltrado },
  { path: 'historial-detalle', component: HistorialDetalle },
];
