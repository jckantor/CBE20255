function mw = molweight(varargin)

% MOLWEIGHT  Computes the molecular weights for a set of chemical species.
%
% SYNTAX
%
%   mw = molweight(formula)
%   mw = molweight(species)
%   mw = molweigth(r)
%
%   Computes the molecular weight of a chemical species. The species may be
%   specified as a chemical formula, a cell array of chemical formulas or
%   as a structure array of atomic representations. If there are no output
%   arguments then a table of molecular weights is displayed.
%
%
% EXAMPLES
%
%   1. Molecular weight of methane
%
%       mw = molweight('CH4')
%
%   2. Molecular weight of methane using a structure array
%
%       r.C = 1;
%       r.H = 4;
%       molweight(r);
%
%   3. Molecular weights of set of compounds
%
%       molweight({'CH4','O2','CO2','H2O'});
%
 
% AUTHOR
%
%    Jeff Kantor
%    December 18, 2010

    % This file is part of larger project for developing Matlab based tools
    % for undergraduate use in Chemical Engineering. The following data
    % structure was adapted from that project.

    persistent ppds;

    if isempty(ppds)
        element = @(str, atomicnumber, amu) amu;
        
        ppds.M  = element('any metal',      0,   NaN);
        ppds.X  = element('any halogen',    0,   NaN);

        ppds.H  = element('hydrogen atom',  1,   1.00794);
        ppds.D  = element('deuterium',      1,   2.01410178);
        ppds.T  = element('tritium',        1,   3.0160492);
        ppds.He = element('helium',         2,   4.0026002);
        ppds.Li = element('lithium',        3,   6.941);
        ppds.Be = element('beryllium',      4,   9.012182);
        ppds.B  = element('boron',          5,  10.811);
        ppds.C  = element('carbon',         6,  12.011);
        ppds.N  = element('nitrogen atom',  7,  14.00674);
        ppds.O  = element('oxygen atom',    8,  15.9994);
        ppds.F  = element('flourine',       9,  18.99840);
        ppds.Ne = element('neon',          10,  20.1797);
        ppds.Na = element('sodium',        11,  22.989768);
        ppds.Mg = element('magnesium',     12,  24.3050);
        ppds.Al = element('aluminium',     13,  26.981539);
        ppds.Si = element('silicon',       14,  28.0855);
        ppds.P  = element('phosphorus',    15,  30.97362);
        ppds.S  = element('sulfur',        16,  32.066);
        ppds.Cl = element('chlorine atom', 17,  35.4527);
        ppds.Ar = element('argon',         18,  39.948);
        ppds.K  = element('potassium',     19,  39.0983);
        ppds.Ca = element('calcium',       20,  40.078);
        ppds.Sc = element('scandium',      21,  44.95591);
        ppds.Ti = element('titanium',      22,  47.88);
        ppds.V  = element('vanadium',      23,  50.9415);
        ppds.Cr = element('chromium',      24,  51.9961);
        ppds.Mn = element('manganese',     25,  54.93085);
        ppds.Fe = element('iron',          26,  55.847);
        ppds.Co = element('cobalt',        27,  58.9332);
        ppds.Ni = element('nickel',        28,  58.69);
        ppds.Cu = element('copper',        29,  63.546);
        ppds.Zn = element('zinc',          30,  65.39);
        ppds.Ga = element('gallium',       31,  69.723);
        ppds.Ge = element('germanium',     32,  72.61);
        ppds.As = element('arsenic',       33,  74.92159);
        ppds.Se = element('selenium',      34,  78.96);
        ppds.Br = element('bromine',       35,  79.904);
        ppds.Kr = element('krypton',       36,  83.80);
        ppds.Rb = element('rubidium',      37,  85.4678);
        ppds.Sr = element('strontium',     38,  87.62);
        ppds.Y  = element('yttrium',       39,  88.90585);
        ppds.Zr = element('zirconium',     40,  91.224);
        ppds.Nb = element('niobium',       41,  92.90638);
        ppds.Mo = element('molybdenum',    42,  95.94);
        ppds.Tc = element('technetium',    43,  98);
        ppds.Ru = element('ruthenium',     44, 101.070);
        ppds.Rh = element('rhodium',       45, 102.9055);
        ppds.Pd = element('palladium',     46, 106.42);
        ppds.Ag = element('silver',        47, 107.8682);
        ppds.Cd = element('cadmium',       48, 112.411);
        ppds.In = element('indium',        49, 114.82);
        ppds.Sn = element('tin',           50, 118.71);
        ppds.Sb = element('antimony',      51, 121.75);
        ppds.Te = element('tellurium',     52, 127.60);
        ppds.I  = element('iodine',        53, 126.90447);
        ppds.Xe = element('xenon',         54, 131.29);
        ppds.Cs = element('cesium',        55, 132.90543);
        ppds.Ba = element('barium',        56, 137.327);
        ppds.La = element('lanthanum',     57, 138.9055);
        ppds.Ce = element('cerium',        58, 140.115);
        ppds.Pr = element('praseodymium',  59, 140.90765);
        ppds.Nd = element('neodymium',     60, 144.24);
        ppds.Pm = element('promethium',    61, 145);
        ppds.Sm = element('samarium',      62, 150.36);
        ppds.Eu = element('europium',      63, 151.965);
        ppds.Gd = element('gadolinium',    64, 157.25);
        ppds.Tb = element('terbium',       65, 158.92534);
        ppds.Dy = element('dysprosium',    66, 162.50);
        ppds.Ho = element('holmium',       67, 164.92032);
        ppds.Er = element('erbium',        68, 167.26);
        ppds.Tm = element('thulium',       69, 168.93421);
        ppds.Yb = element('ytterbium',     70, 173.04);
        ppds.Lu = element('lutetium',      71, 174.967);
        ppds.Hf = element('hafnium',       72, 178.49);
        ppds.Ta = element('tantalum',      73, 180.9479);
        ppds.W  = element('tungsten',      74, 183.85);
        ppds.Re = element('rhenium',       75, 186.207);
        ppds.Os = element('osmium',        76, 190.2);
        ppds.Ir = element('iridium',       77, 192.22);
        ppds.Pt = element('platinum',      78, 195.09);
        ppds.Au = element('gold',          79, 196.96654);
        ppds.Hg = element('mercury',       80, 200.59);
        ppds.Tl = element('thallium',      81, 204.3833);
        ppds.Pb = element('lead',          82, 207.2);
        ppds.Bi = element('bismuth',       83, 208.98037);
        ppds.Po = element('polonium',      84, 209);
        ppds.At = element('astatine',      85, 210);
        ppds.Rn = element('radon',         86, 222);
        ppds.Fr = element('francium',      87, 223);
        ppds.Ra = element('radium',        88, 226.025);
        ppds.Ac = element('actinium',      89, 227.028);
        ppds.Th = element('thorium',       90, 232.0381);
        ppds.Pa = element('protactinium',  91, 231.03588);
        ppds.U  = element('uranium',       92, 238.0289);
        ppds.Np = element('neptunium',     93, 237.0482);
        ppds.Pu = element('plutonium',     94, 244);
        ppds.Am = element('americium',     95, 243);
        ppds.Cm = element('curium',        96, 247);
        ppds.Bk = element('berkelium',     97, 247);
        ppds.Cf = element('californium',   98, 251);
        ppds.Es = element('einsteinium',   99, 252);
        ppds.Fm = element('fermium',      100, 257);
        ppds.Q  = element('charge',         0,   0);
        ppds.e  = element('electron',       0,   0);

    end
    
    assert(nargin > 0, 'molweight:input', ['No input. Expects a cell ', ...
                        'array of formulas or struct array of atoms.']);
    assert(nargin < 2, 'molweight:input', 'Unexpected extra inputs.');
     
    % Process function argument to produce a cell array of chemical
    % formulas and structure array of atomic representations.
    
    switch class(varargin{1})
        case 'char'                      % Single formula
            species = varargin;
            r = parse_formula(species);
        
        case 'cell'                      % Cell array of formulas
            species = varargin{1};
            r = parse_formula(species);
            
        case 'struct'                    % Structure array
            r = varargin{1};
            species = hillformula(r);
            
        otherwise
            error('molweight:input',['requires cell array of chemical ',...
              'formulas or a structure array of atomic representations']);
    end

    % For each element of the structure array, compute a molecular weight

    mw = zeros(size(r));
    atoms = fields(r);
    
    for n = 1:size(r(:))
        for i = 1:length(atoms)
            
            % The following check is needed to avoid add adding NaN in
            % cases where M or X appear in atoms.
            
            if r(n).(atoms{i}) > 0
                mw(n) = mw(n) + ppds.(atoms{i})*r(n).(atoms{i});
            end
            
        end
    end
    
    % If no outputs, then display results

    if nargout == 0
        fprintf('\n');
        fprintf('%-25s  %8s\n','Species','Mol. Wt.');
        fprintf('%-25s  %8s\n','-------','--------');
        for n = 1:size(mw(:))
            fprintf('%-25s  %8.2f\n',species{n},mw(n));
        end  
    end

end

function r = parse_formula(varargin)

% PARSE_FORMULA Parses a chemical formula to form an atomic representation.
%
% SYNTAX
%
% r = parse_formula(str)
% r = parse_formula({str1,str2,str3, ...})
%
%   Parses chemical formulas and returns a structure array holding the an
%   atomic representation of the chemical formulae. The input is a string
%   or a cell array of strings.
%
%
% EXAMPLES
% 
%   1. Chemical formulas of varying complexity
% 
%       parse_formula('H2O');            % Water
%       parse_formula('NaHCO3');         % Sodium Bicarbonate
%       parse_formula('(CH4)8(H2O)46');  % Methane Clathrate
%       parse_formula('CH3COOCH2CH3');   % Ethyl Acetate
%       parse_formula('MnO4-');          % Negative Charge Ion
%
%       parse_formula('dCH4');           % Returns error message
%
%   2. Create an structure array of atomic representations for a set of
%      compounds
%
%       r = parse_formula({'CH4','O2','CO2','H2O'});
%
%
% USAGE NOTES
%
%   1. Formulas are made of up of sequences of elements followed by
%      integers  indicating the number of included atoms. Omitted integers
%      are assumed to be one.
%
%   2. Elements are the conventional one or two character abbreviations.
%      The character is captialized. If present, the second character is
%      lower case. In addition to the standard elements, the parser allows
%      for
%
%       Symbol  Entity                 Interpretation
%          e    electron               like an element with MW = 0
%          D    deuterium              an element
%          T    tritium                an element
%          M    any metal              like an element, mw = NaN
%          X    any halogen            like an element, mw = NaN
%          Me   methyl group (CH3)     CH3 substituted for Me
%          Et   ethyl group (C2H5)     C2H5 substituted for Et
%          Bu   butyl group (C4H9)     C4H9 substituted for Bu
%          Ph   phenol group (C6H5)    C6H5 substituted for Ph
%
%   3. Subgroups may be included between parenthesis or brackets followed
%      by an integer indicating number of repetitions. Two levels of
%      subgrouping are allowed.
%
%   4. A terminal lower case suffix denoting phases will be correctly
%      parsed. The phase must be one of (aq), (l), (g), or (s).
%
%   5. The charge on an ionic species is appended as a + or - followed by
%      an optional integer.  Examples are H+, OH-, or Ca+2.
%
%   6. The bare electron e- is used in balancing chemical half reactions.
%
%   7. Error messages are generated for invalid fomulas
%
%   8. str can be a cell array of chemical formula. The results is a
%      structure array. The elements of the output structure array are in
%      one-to-one correspondence with elements of the cell array. For
%      example
%
%          r = parse_formula({'CH4','CH3OH','CHOOH'})
%
%      r(1) holds the atomic formula for CH4, r(2) for CH3OH, and r(3) for
%      CHOOH.

% AUTHOR
%
%   Jeff Kantor
%   December 18, 2010


    assert(nargin > 0, 'parse_formula:input', ['No input. Expects a  ', ...
                        'string or cell array of chemical formulas.']);
    assert(nargin < 2, 'stoich:input', 'Unexpected extra inputs.');
    
    switch class(varargin{1})
        case 'char'                      % Single formula
            str = varargin;
        
        case 'cell'                      % Cell array of formulas
            str = varargin{1};
            
        otherwise
            error('parse_formula:input',['requires cell array of  ',...
              'chemical formulas.']);
    end
    
    assert(iscellstr(str), 'parse_formula:input', ...
        'Formulas must be strings.');
    
    % Trim any whitespace at front or back
    
    str = strtrim(str);
    
    % Remove phase information. This information is currently neglected. In
    % a later version we may wish to incorporate phase into a more complete
    % data structure for representing chemical formula.
    
    prex = '|\((aq|g|l|s)\)$';
    str = regexprep(str,prex,'');
    
    % Substitute for some common chemical abbreviations
    
    str = regexprep(str,'Bu','C4H9');    % Butyl
    str = regexprep(str,'Et','C2H5');    % Ethyl
    str = regexprep(str,'Me','CH3');     % Methyl
    str = regexprep(str,'Ph','C6H5');    % Phenol

    % Apply the main parser to every element of str

    q = cellfun(@(s)parse_formula_(s,3),str,'Uniform',false);

    % Union of all atomic species

    atoms = {};
    for i = 1:length(q(:))
        atoms = union(atoms, fields(q{i}));
    end
    
    % Add all atomic species to all structures.

    for i = 1:length(q(:))
        for j = 1:length(atoms)
            if ~ismember(atoms{j},fields(q{i}))
                q{i}.(atoms{j}) = 0;
            end
        end
    end

    % Form the structure array to have the same shape as str
    
    r = reshape([q{:}],size(str));
   
end % parse_formula


function r = parse_formula_(str,kdepth)

    assert(kdepth > 0, 'parse_formula_:Recursion', ...
        'Reached maximum recursion depth');

    r = struct([]);
    
    % Regular expression returning tokens for element and number
    % sexpr matches single elements followed by a digit, or a +/-
    % followed by a digit to denote charge
    
    persistent srex;  % Regexp pattern to match elements and charges
    persistent grex;  % Regexp pattern to match groups
    
    if isempty(srex) || isempty(grex)
        srex = ['(A[lrsgutcm]|B[eraik]?|C[laroudsemf]?|D[y]?|E[urs]|', ...
                'F[erm]?|G[aed]|H[eofgas]?|I[nr]?|Kr?|L[iaur]|', ...
                'M[gnodt]?|N[eaibdpos]?|Os?|P[drmtboau]?|R[buhenaf]|', ...
                'S[icernbmg]?|T[icebmalh]?|U|V|W|X[e]?|Yb?|Z[nr])', ...
                '(\d*\.\d+|\d*)', ...
                '|(e|+|-)(\d*)'];
        grex = '|\(([^\)]*)\)(\d*\.\d+|\d*)|\[([^\]]*)\](\d*\.\d+|\d*)';
    end

    % Parse formula for chemical groups. This picks out anything that looks
    % an element followed by a number, or a subgroup within parentheses.
    % The tokens are returned in the cell array u. Each u{k} has two
    % elements, the first is a string denoting the group, and the second is
    % number string of repetitions.

    [u,s,e] = regexp(str,[srex,grex],'tokens','start','end');

    % Report any parsing errors. A parse error occurs if there are any
    % characters not matched as tokens. We scan the start and end positions
    % of the tokens to determine if there are any gaps.

    g(1:length(str)) = '^';
    for i = 1:length(s);
        g(s(i):e(i)) = ' ';
    end
    
    assert(all(g ~= '^'), 'parse_formula:ParseError', ...
        'Could not parse formula:\n    %s\n    %s\n', str, char(g));
    
    % Extract atom tokens from the first part of each token
    
    tok = cellfun(@(v)v{1},u,'Uni',false);

    % Extract counts from the second part of each token, convert to
    % doubles, empty counts set to 1
    
    cnt = cellfun(@(v)v{2},u,'Uni',false);
    cnt = str2double(cnt);
    cnt(isnan(cnt)) = 1;
    
    % Loop over tokens

    for j = 1:length(u)

        % See if token matches an element

        if strcmp(tok{j},regexp(tok{j},srex,'match'))

            % The token exactly matches an element.
            % Change + or - tokens to 'Q'.
            
            tok{j} = regexprep(tok{j},'+','Q');

            if strcmp(tok{j}, '-')
                tok{j} = 'Q';
                cnt(j) = -cnt(j);
            end

            % Update atomic representation, adding a field if needed.

            if isfield(r,tok{j})
                r.(tok{j}) = r.(tok{j}) + cnt(j);
            else
                r(1).(tok{j}) = cnt(j);
            end

        else 

            % The token must be a group, so do a recursion to find
            % an atomic represenation of the group.

            q = parse_formula_(tok{j},kdepth-1);

            % Updatethe  atomic representation to include the group.
            % Add fields if needed. Multiply by number of groups in the
            % formula we're parsing.

            f = fields(q);

            for k = 1:length(f)

                if isfield(r,f{k})
                    r.(f{k}) = r.(f{k}) + cnt(j)*q.(f{k});
                else
                    r(1).(f{k}) = cnt(j)*q.(f{k});
                end

            end
        end
    end
        
end % parse_formula_

function species = hillformula(varargin)
%
% HILLFORMULA  Produce a cell array of chemical formulas in Hill Notation.
%
%   species = hillformula(r)
%   species = hillformula(species)
%
%   Construct a cell array of chemical formula strings in Hill notation.
%   The input is either a cell array of chemical formulas or a structure
%   array of atomic representations.
%
%
% EXAMPLES
%   
%   1. Construct formula for methane
%
%       r.C = 1;
%       r.H = 4;
%       hillformula(r);       
%
%   2. Roundtrip construction for methanol
%
%       r = parse_formula('CH3OH');
%       hillformula(r)
%
%   3. Convert formula to Hill notation
%
%      sp = hillformula('H2SO4');
%
%
% USAGE NOTES
%
%   1. Starting with a chemical formula s1,
%
%          s2 = hillformula(s1)
%
%      projects the chemical onto a simpler representation s2. This is not
%      unique, there may be multiple formulas (isomers) that result in the
%      same string s2.
%
%   2. Starting with an atomic representation r1, the combination
%
%          s  = hillformula(r1)
%          r2 = parse_formula(s)
%
%      will return the same atomic representation.

% Author
%
%   Jeff Kantor
%   December 18, 2010

    assert(nargin > 0, 'hillfomula:input', ['No input. Expects a ', ...
    	'cell array of formulas or struct array of atoms.']);
    assert(nargin < 2, 'hillfomula:input', 'Unexpected extra inputs.');
     
    % Process function argument to produce a cell array of chemical
    % formulas and structure array of atomic representations.
    
    switch class(varargin{1})
        case 'char'                      % Single formula
            r = parse_formula(varargin);
        
        case 'cell'                      % Cell array of formulas
            r = parse_formula(varargin{1});
            
        case 'struct'                    % Structure array
            r = varargin{1};
            
        otherwise
            error('hillfomula:input',['requires cell array of chemical ',...
              'formulas or a structure array of atomic representations']);
    end
    
    % Use hillformula_ to perform calculations for each element of array r
    
    species = arrayfun(@hillformula_,r,'UniformOutput',false);

end


function str = hillformula_(r)

    % Put fields in alphabetical order

    atoms = sort(fields(r));
    
    % The fields of r is union set of atoms present in the various chemical
    % species. We obtain these fields and put them in Hill order.
    
    if ismember('C',atoms) && (r.C > 0)
        a = intersect({'C','H','D','T'},atoms);
        b = setdiff(atoms,{'C','H','D','T'});
        atoms = [a(:); b(:)];
    end
    
    % If Q is present, then Q always goes to the end of the line

    if ismember('Q',atoms) && (r.Q ~= 0)
        a = setdiff(atoms,{'Q'});
        atoms = [a(:); 'Q'];
    end
        
    str = '';
    
    for k = 1:length(atoms);
        switch atoms{k}
            case 'Q'
                if r.(atoms{k}) <= -2
                    str = strcat(str,num2str(r.(atoms{k})));
                elseif r.(atoms{k}) == -1
                    str = strcat(str,'-');
                elseif r.(atoms{k}) == 1
                    str = strcat(str,'+');
                elseif r.(atoms{k}) >= 2
                    str = strcat(str,'+',num2str(r.(atoms{k})));
                end
            otherwise
                if (r.(atoms{k}) > 0) && (r.(atoms{k}) ~= 1)  
                    str = strcat(str,atoms{k},num2str(r.(atoms{k})));
                elseif r.(atoms{k}) == 1
                    str = strcat(str,atoms{k});
                end
        end
    end
end

