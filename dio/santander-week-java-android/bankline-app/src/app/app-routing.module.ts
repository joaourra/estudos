import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MovimentacaoNewComponent } from './components/movimentacao-new/movimentacao-new.component';
import { MovimentacaoListComponent } from './components/movimentacao-list/movimentacao-list.component';
import { CorrentistaComponent } from './components/correntista/correntista.component';

const routes: Routes = [

  { path: 'movimentacoes-new', component: MovimentacaoNewComponent },
  { path: 'movimentacoes', component: MovimentacaoListComponent },
  { path: '', redirectTo: 'movimentacoes', pathMatch: 'full' },
  { path: 'correntistas', component: CorrentistaComponent },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
