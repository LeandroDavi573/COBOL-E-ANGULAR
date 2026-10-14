import { Component } from '@angular/core';
import { Extrato } from './extrato/extrato';

@Component({
  selector: 'app-root',
  imports: [Extrato],
  template: '<app-extrato />',
})
export class App {}
