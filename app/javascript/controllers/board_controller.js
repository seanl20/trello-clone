import { Controller } from '@hotwired/stimulus'
import axios from 'axios'
import { get, map } from 'lodash-es'

export default class extends Controller {
  HEADERS = { 'ACCEPT': 'application/json' }

  connect() {
    axios.get(this.element.dataset.apiUrl, { header: this.HEADERS}).then((response) => {
      const boards = this.buildBoards(response["data"])

      const kanban = this.buildKanban(boards);
      this.cursoriftyHeaderTitles();
      this.addLinksToHeaderTitle(boards);
      this.addHeaderDeleteButtons(boards, kanban)
    });
  }

  buildBoards(boardsData) {
    return map(boardsData['data'], (board) => {
      return {
        'id': get(board, 'id'),
        'title': get(board, 'attributes.title'),
        'class': this.buildClassList(),
        'item': this.buildItems(get(board, 'attributes.items.data'))
      }
    });
  }

  buildClassList(){
    return `text-white, bg-blue-700`
  }

  buildItems(items) {
    return map(items, (item) => {
      return {
        'id': get(item, 'id'),
        'title': get(item, 'attributes.title'),
        'class': this.buildClassList(),
        'list-id': get(item, 'attributes.list_id')
      }
    });
  }

  buildKanban(boards){
    return new jKanban({
      element: `#${this.element.id}`,
      boards: boards,
      itemAddOptions: {
        enabled: true
      },
      buttonClick: (el, boardId) => {
        Turbo.visit(`/boards/${this.element.dataset.boardId}/lists/${boardId}/items/new`)
      },
      dragendBoard: (el) => {
        this.updateListPosition(el);
      },
      dropEl: (el, target, source, sibling) => {
        const targetItems = Array.from(target.getElementsByClassName('kanban-item'));
        const sourceItems = Array.from(source.getElementsByClassName('kanban-item'));

        targetItems.forEach((item, index) => {
          item.dataset.position = index;
          item.dataset.listId = target.closest('.kanban-board').dataset.id;
        });

        sourceItems.forEach((item, index) => {
          item.dataset.position = index;
          item.dataset.listId = source.closest('.kanban-board').dataset.id;
        });


      }
    });
  }

  updateListPosition(el) {
    axios.put(`${this.element.dataset.listPositionApiUrl}/${el.dataset.id}`, {
      position: el.dataset.order -1
    },{
      headers: this.HEADERS
    })
    .then((response) => {
      console.log('reponse: ', response)
    });
  }

  cursoriftyHeaderTitles() {
    this.getHeaderTitles().forEach((headerTitle) => {
      headerTitle.classList.add('cursor-pointer');
    });
  }

  getHeaderTitles() {
    return Array.from(document.getElementsByClassName('kanban-title-board'));
  }

  addLinksToHeaderTitle(boards) {
    this.getHeaderTitles().forEach((headerTitle, index) => {
      headerTitle.addEventListener('click', (e) => {
        e.preventDefault();
        Turbo.visit(`${this.element.dataset.boardListsUrl}/${boards[index].id}/edit`);
      });
    });
  }

  addHeaderDeleteButtons(boards, kanban) {
    this.getHeaders().forEach((header, index) => {
      header.appendChild(this.buildBoardDeleteButton(boards[index].id, kanban));
    });
  }

  getHeaders() {
    return Array.from(document.getElementsByClassName('kanban-board-header'));
  }

  buildBoardDeleteButton(boardId, kanban) {
    const button = document.createElement('button');
    button.classList.add('kanban-title-button', 'btn', 'btn-default', 'btn-xs', 'mr-2');
    button.textContent = 'x';
    button.addEventListener('click', (e) => {
      e.preventDefault();

      this.deleteBoard(boardId, kanban)
    });
    
    return button
  }

  deleteBoard(boardId, kanban) {
    axios.delete(`${this.element.dataset.boardListsUrl}/${boardId}`, {
      headers: this.HEADERS
    })
    .then((_) => {
      kanban.removeBoard(boardId)
    })
  }
}
