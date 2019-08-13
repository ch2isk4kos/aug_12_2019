# Domain

  @user
    |
    ^
@ranking -< @selection >- @player


# Associations:

**User**
has_many :rankings

**Ranking**
belongs_to :user
has_many :selections
has_many :players, through: selections

**Selection**
belongs_to :ranking
belongs_to :player

**Player**
has_many :selection
has_many :rankings, through: :selections

# Attributes

*User*
* username
* email
* password_digest

$ rails g resource User username email password_digest --no-test-framework

*Ranking*
* content
* user_id

$ rails g resource Ranking content:text user_id:integer user:belongs_to --no-test-framework

*Selection*
* rank_position
* ranking_id
* player_id

$ rails g model Selection ranking_position:string ranking_id:integer player_id:integer ranking:belongs_to player:belongs_to --no-test-framework

*Player*
* name

$ rails g resource Player name --no-test-framework


# ranking_params

ranking = [
    description: "This is my description",

    selections_attributes: [
        { rank_position: "1", player_id: 7 },
        { rank_position: "2", player_id: 15 },
        { rank_position: "3", player_id: 11 },
        { rank_position: "4", player_id: 23 },
        { rank_position: "5", player_id: 33 },

        player_ids: [],
        player_attributes: [
            { name: "", position: "", number: 0, team_id: 2 },
        ]
    ],
]


########################################################################################################


# REFACTOR: [:category]


              @user
                |
                ^
@category -< @ranking -< @selection >- @player


# Added Associations

**Category**
has_many :rankings

**Ranking**
belongs_to :category

# Added Attributes

*Category*
* title

$ rails g resource Category title

*Ranking*
* category_id

$ rails g migration addCategoryIdToRankings category_id:integer category:belongs_to


########################################################################################################
