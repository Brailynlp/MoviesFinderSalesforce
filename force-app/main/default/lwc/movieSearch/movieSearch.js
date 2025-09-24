import { LightningElement, track } from 'lwc';
import searchMoviesWithRating from '@salesforce/apex/MovieService.searchMoviesWithRating';
import getMovieDetail from '@salesforce/apex/MovieService.getMovieDetail';
import saveMovieDetail from '@salesforce/apex/MovieService.saveMovieDetail';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class MovieSearch extends LightningElement {
    @track movies;
    searchTerm = '';

    handleChange(event) {
        this.searchTerm = event.target.value;
    }

    async handleSearch() {
        try {
            this.movies = await searchMoviesWithRating({ title: this.searchTerm });
        } catch (error) {
            console.error('Error:', error);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: 'No se pudieron buscar las películas',
                variant: 'error'
            }));
        }
    }

    async handleSave(event) {
        const imdbId = event.target.dataset.id;
        try {
            const detail = await getMovieDetail({ imdbId });
            await saveMovieDetail({ md: detail });
            this.dispatchEvent(new ShowToastEvent({
                title: 'Éxito',
                message: 'Película guardada correctamente',
                variant: 'success'
            }));
        } catch (error) {
            console.error('Error al guardar:', error);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: 'No se pudo guardar la película',
                variant: 'error'
            }));
        }
    }
}
