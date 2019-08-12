# Domain
@ranking -< @selection >- @player

# Associations:

**Ranking**
has_many :selections
has_many :players, through: selections

**Selection**
belongs_to :ranking
belongs_to :player

**Player**
has_many :teams

# Attributes

*Ranking*
* description

$ rails g resource Ranking description:text

*Selection*
* rank_position
* ranking_id
* player_id

$ rails g model Selection ranking_position:string ranking_id:integer player_id:integer ranking:belongs_to player:belongs_to

*Player*
* name
* position
* number

$ rails g resource Player name position number:integer


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


# REFACTOR: 1   => [Category]

              @user
                |
                ^
@category -< @ranking -< @selection >- @player


# Added Associations

**User**
has_many :rankings

**Ranking**
belongs_to :user

# Added Attributes

*User*
* username
* email
* password_digest

$ rails g resource User username email password_digest

*Ranking*
* user_id

$ rails g migration addUserIdToRankings user_id:integer user:belongs_to


########################################################################################################
